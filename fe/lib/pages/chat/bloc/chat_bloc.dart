import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:meta/meta.dart';
import 'package:fe/gql/get_new_messages.req.gql.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';
import 'package:fe/gql/get_new_reactions.req.gql.dart';

import '../../../service_locator.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static const SINGLE_QUERY_LIMIT = 20;

  bool appendingNewMessages = true;

  final _gqlClient = getIt<AuthGqlClient>();
  final ThreadCubit _threadCubit;

  final List<StreamSubscription> _subscriptions = [];

  ChatBloc({required ThreadCubit threadCubit})
      : _threadCubit = threadCubit,
        super(ChatState.loading()) {
    on<RetryEvent>((_, emit) => _retry(emit));
    on<FetchMessagesEvent>((event, emit) => _fetchMessages(emit),
        transformer: droppable());

    on<_ThreadChangeEvent>((event, emit) => _switchThread(emit));
    _threadCubit.stream.listen((event) => add(_ThreadChangeEvent()));
    on<_NewMessageEvent>((event, emit) => emit(ChatState.fetchedMessages(
        FetchedMessages.withNewMessage(
            old: state.join((fm) => fm, (_) => null, (_) => null, (_) => null)!,
            newMessage: event.newMessage))));
    on<_UpdatedReactionEvent>(_handleUpdatedReaction);
  }

  Stream<_UpdatedReactionEvent> _newReactionsStream(UuidType threadId) async* {
    await for (final reactions in _gqlClient
        .request(GGetNewReactionsReq((q) => q..vars.threadId = threadId))) {
      for (final reactionData in reactions.message_reactions) {
        final reaction = Reaction(
            messageId: reactionData.message.id,
            likedBy:
                User(name: reactionData.user.name, id: reactionData.user.id),
            id: reactionData.id,
            type: ReactionEmoji.fromGql(reactionData.reaction_type));

        final message = state
            .join((fm) => fm, (_) => null, (_) => null, (_) => null)
            ?.getMessage(reaction.messageId);

        if (message == null) {
          continue;
        }

        if (reactionData.deleted &&
            message.reactions.lookup(reaction) != null) {
          yield _UpdatedReactionEvent(
              updatedReaction: reaction, deleted: reactionData.deleted);
        } else if (!reactionData.deleted &&
            message.reactions.lookup(reaction) == null) {
          yield _UpdatedReactionEvent(
              updatedReaction: reaction, deleted: reactionData.deleted);
        }
      }
    }
  }

  Stream<Message> _newMessageStream(UuidType threadId) async* {
    await for (final messages in _gqlClient
        .request(GGetNewMessagesReq((q) => q..vars.threadId = threadId))
        .map((resp) => resp.messages.map((data) => Message(
              user: User(
                  id: data.user.id,
                  name: data.user.name,
                  profilePictureUrl: data.user.profile_picture),
              reactions: {
                ...data.message_reactions.map((reaction) => Reaction(
                    messageId: data.id,
                    type: ReactionEmoji.fromGql(reaction.reaction_type),
                    id: reaction.id,
                    likedBy:
                        User(id: reaction.user.id, name: reaction.user.name)))
              },
              id: data.id,
              message: data.message,
              isImage: data.is_image,
              createdAt: data.created_at,
              updatedAt: data.updated_at,
            )))) {
      for (final message in messages) {
        if (state.join((fm) => fm.getMessage(message.id) == null, (_) => false,
            (_) => false, (p0) => false)) {
          yield message;
        }
      }
    }
  }

  Future<void> _fetchMessages(Emitter<ChatState> emit) async {
    GQueryMessagesInThreadData resp;

    final before = state.join((fm) {
          if (fm.messages.isNotEmpty) {
            return fm.messages.last.createdAt;
          }
        }, (_) => null, (_) => null, (_) => null) ??
        clock.hoursFromNow(5);

    try {
      resp = await _gqlClient
          .request(GQueryMessagesInThreadReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.before = before
            ..vars.threadId = _threadCubit.state.thread!.id))
          .first;
    } on Failure catch (f) {
      emit(ChatState.failure(f));
      return;
    }

    final chats = resp.messages
        .map((message) => Message(
            isImage: message.is_image,
            updatedAt: message.updated_at,
            id: message.id,
            user: User(
                name: message.user.name,
                profilePictureUrl: message.user.profile_picture,
                id: message.user.id),
            reactions: {
              ...message.message_reactions.map((reaction) => Reaction(
                  type: ReactionEmoji.fromGql(reaction.reaction_type),
                  id: reaction.id,
                  messageId: message.id,
                  likedBy:
                      User(name: reaction.user.name, id: reaction.user.id)))
            },
            message: message.message,
            createdAt: message.created_at))
        .toList();

    final List<Message> oldMessages = state.join(
        (fm) => fm.messages.toList(), (_) => [], (_) => [], (_) => []);

    final hasReachedMax = chats.length < SINGLE_QUERY_LIMIT;

    emit(ChatState.fetchedMessages(FetchedMessages(
        messages: [...oldMessages, ...chats], hasReachedMax: hasReachedMax)));
  }

  void _handleUpdatedReaction(
      _UpdatedReactionEvent event, Emitter<ChatState> emitter) {
    FetchedMessages? old =
        state.join((fm) => fm, (_) => null, (_) => null, (_) => null);
    if (old == null) {
      return;
    }

    if (event.deleted) {
      emit(ChatState.fetchedMessages(FetchedMessages.withoutReaction(
          old: old, deletedReaction: event.updatedReaction)));
    } else {
      emit(ChatState.fetchedMessages(FetchedMessages.withNewReaction(
          old: old, newReaction: event.updatedReaction)));
    }
  }

  Future<void> _switchThread(Emitter<ChatState> emit) async {
    final newThread = _threadCubit.state.thread;
    emit(ChatState.loading());

    if (newThread == null) {
      emit(ChatState.noThread());
      return;
    }

    await _fetchMessages(emit);

    // ignore: unawaited_futures
    Future.wait(_subscriptions.map((e) => e.cancel()));

    _subscriptions.clear();
    _subscriptions.addAll([
      _newMessageStream(newThread.id).listen(
          (newMessage) => add(_NewMessageEvent(newMessage: newMessage))),
      _newReactionsStream(newThread.id)
          .listen((updatedReactionEvent) => add(updatedReactionEvent))
    ]);
  }

  Future<void> _retry(Emitter<ChatState> emit) async {
    await _switchThread(emit);
  }
}
