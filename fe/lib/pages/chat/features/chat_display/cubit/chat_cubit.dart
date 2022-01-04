import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:fe/gql/get_new_messages.req.gql.dart';

import 'package:fe/gql/query_messages_in_chat.req.gql.dart';
import 'package:fe/gql/query_messages_in_chat.data.gql.dart';
import 'package:fe/gql/get_new_reactions.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show Gmessage_types_enum;

import '../../../../../service_locator.dart';
import 'chat_state.dart';

class _UpdatedReaction {
  final bool deleted;
  final Reaction reaction;

  const _UpdatedReaction({required this.deleted, required this.reaction});
}

/// holds data that can be used to create messages.
/// used to unify different message sources
class _MessageDataCore {
  final Gmessage_types_enum type;
  final String body;
  final User user;
  final UuidType id;
  final DateTime createdAt;
  final Map<UuidType, Reaction>? reactions;
  final DateTime updatedAt;

  _MessageDataCore(
      {required this.type,
      required this.body,
      required this.user,
      required this.updatedAt,
      required this.id,
      required this.createdAt,
      this.reactions});
}

class ChatCubit extends Cubit<ChatState> {
  static const SINGLE_QUERY_LIMIT = 20;

  final _gqlClient = getIt<AuthGqlClient>();
  final _handler = getIt<Handler>();
  final Thread _thread;

  final List<StreamSubscription> _subscriptions = [];

  bool _fetching = false;

  ChatCubit({required Thread thread})
      : _thread = thread,
        super(const ChatState.loading()) {
    initalize();
  }

  Future<void> initalize() async {
    emit(const ChatState.loading());

    try {
      await fetchMessages();
    } on Exception catch (e) {
      emit(ChatState.failure(_handler.exceptionToFailure(e)));
      return;
    }

    _subscriptions.clear();
    _subscriptions.addAll([
      _newMessageStream(_thread.id).listen(_addMessage),
      _newReactionsStream(_thread.id).listen(_updateReaction)
    ]);
  }

  Stream<_UpdatedReaction> _newReactionsStream(UuidType chatId) async* {
    await for (final reactions in _gqlClient
        .request(GGetNewReactionsReq((q) => q..vars.sourceId = chatId))) {
      for (final reactionData in reactions.message_reactions) {
        final reaction = Reaction(
            messageId: reactionData.message.id,
            likedBy:
                User(name: reactionData.user.name, id: reactionData.user.id),
            id: reactionData.id,
            type: ReactionEmoji.fromGql(reactionData.reaction_type));

        final message = state.maybeMap(
            orElse: () => null,
            withMessages: (value) => value.messages[reaction.messageId]);

        if (message == null) {
          continue;
        }

        if (reactionData.deleted &&
            message.reactions.containsKey(reaction.id)) {
          yield _UpdatedReaction(
              reaction: reaction, deleted: reactionData.deleted);
        } else if (!reactionData.deleted &&
            !message.reactions.containsKey(reaction.id)) {
          yield _UpdatedReaction(
              reaction: reaction, deleted: reactionData.deleted);
        }
      }
    }
  }

  Stream<Message> _newMessageStream(UuidType chatId) async* {
    await for (final messageFutures in _gqlClient
        .request(GGetNewMessagesReq((q) => q..vars.sourceId = chatId))
        .map((resp) => resp.messages.map((data) => _messageFromMessageCore(
            _MessageDataCore(
                body: data.body,
                createdAt: data.created_at,
                id: data.id,
                type: data.message_type,
                updatedAt: data.updated_at,
                user: User(
                  id: data.user.id,
                  name: data.user.name,
                ),
                reactions: Map.fromEntries(data.message_reactions.map(
                    (reaction) => MapEntry(
                        reaction.id,
                        Reaction(
                            messageId: data.id,
                            type: ReactionEmoji.fromGql(reaction.reaction_type),
                            id: reaction.id,
                            likedBy: User(
                                id: reaction.user.id,
                                name: reaction.user.name)))))))))) {
      final messages = await Future.wait(messageFutures);

      for (final message in messages) {
        if (state.maybeMap(
            withMessages: (withMessages) =>
                withMessages.messages[message.id] == null,
            orElse: () => false)) {
          yield message;
        }
      }
    }
  }

  Future<void> fetchMessages() async {
    if (_fetching) {
      return;
    }
    _fetching = true;

    GQueryMessagesInChatData resp;

    final before = state.maybeMap(
        orElse: () => clock.hoursFromNow(5),
        withMessages: (fm) {
          if (fm.messages.isNotEmpty) {
            int earliest = DateTime.now().millisecondsSinceEpoch;

            for (final message in fm.messages.values) {
              final messageCreated = message.createdAt.millisecondsSinceEpoch;
              if (messageCreated < earliest) {
                earliest = messageCreated;
              }
            }

            return DateTime.fromMillisecondsSinceEpoch(earliest);
          }
        });

    try {
      resp = await _gqlClient
          .request(GQueryMessagesInChatReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.before = before
            ..vars.threadId = _thread.id))
          .first;
    } on Failure catch (f) {
      emit(ChatState.failure(f));
      return;
    }

    final chats = (await Future.wait(resp.messages.map((messageData) =>
            _messageFromMessageCore(_MessageDataCore(
                type: messageData.message_type,
                body: messageData.body,
                user:
                    User(id: messageData.user.id, name: messageData.user.name),
                updatedAt: messageData.updated_at,
                id: messageData.id,
                createdAt: messageData.created_at,
                reactions: Map.fromEntries(messageData.message_reactions.map(
                    (reaction) => MapEntry(
                        reaction.id,
                        Reaction(
                            type: ReactionEmoji.fromGql(reaction.reaction_type),
                            id: reaction.id,
                            messageId: messageData.id,
                            likedBy: User(
                                name: reaction.user.name,
                                id: reaction.user.id))))))))))
        .map((e) => MapEntry(e.id, e));

    final Map<UuidType, Message> oldMessages =
        state.maybeMap(withMessages: (fm) => fm.messages, orElse: () => {});

    final hasReachedMax = chats.length < SINGLE_QUERY_LIMIT;

    final newMessages = Map.fromEntries([...oldMessages.entries, ...chats]);

    emit(ChatState.withMessages(newMessages, hasReachedMax));

    _fetching = false;
  }

  Future<Message> _messageFromMessageCore(_MessageDataCore messageData) async {
    switch (messageData.type) {
      case Gmessage_types_enum.TEXT:
        return Message.text(
            user: messageData.user,
            id: messageData.id,
            createdAt: messageData.createdAt,
            text: messageData.body,
            updatedAt: messageData.updatedAt,
            reactions: messageData.reactions ?? {});
      case Gmessage_types_enum.IMAGE:
        return Message.image(
          user: messageData.user,
          id: messageData.id,
          createdAt: messageData.createdAt,
          sourceId: messageData.id,
          updatedAt: messageData.updatedAt,
        );
      default:
        throw Failure(
            status: FailureStatus.Custom,
            customMessage: 'unhandled message type: ${messageData.type.name}');
    }
  }

  void _addMessage(Message message) {
    final Map<UuidType, Message> messages = state.maybeWhen(
        orElse: () => {}, withMessages: (messages, _) => messages);

    final newMessages = Map<UuidType, Message>.fromEntries(
        [...messages.entries, MapEntry(message.id, message)]);

    emit(state.maybeMap(
        withMessages: (messageState) =>
            messageState.copyWith(messages: newMessages),
        orElse: () => ChatState.withMessages(newMessages)));
  }

  void _updateReaction(_UpdatedReaction event) {
    final oldMessages =
        state.maybeWhen(withMessages: (old, _) => old, orElse: () => null);

    if (oldMessages == null) {
      return;
    }

    final oldMessage = oldMessages[event.reaction.messageId];

    if (oldMessage == null) return;

    Map<UuidType, Reaction> newMessageReactions;
    if (event.deleted) {
      newMessageReactions = Map<UuidType, Reaction>.from(oldMessage.reactions)
        ..remove(event.reaction.id);
    } else {
      newMessageReactions = Map<UuidType, Reaction>.from(oldMessage.reactions)
        ..[event.reaction.id] = event.reaction;
    }

    final oldMessagesWithNewReaction = Map<UuidType, Message>.from(oldMessages)
      ..[oldMessage.id] = oldMessage.copyWith(reactions: newMessageReactions);

    emit(ChatState.withMessages(oldMessagesWithNewReaction));
  }
}
