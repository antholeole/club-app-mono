import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:ferry/ferry.dart';
import 'package:meta/meta.dart';
import 'package:fe/gql/get_new_messages.req.gql.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';

import '../../../service_locator.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static const SINGLE_QUERY_LIMIT = 20;

  bool appendingNewMessages = true;

  final _gqlClient = getIt<AuthGqlClient>();
  final ThreadCubit _threadCubit;
  StreamSubscription<Iterable<Message>>? _subscription;

  ChatBloc({required ThreadCubit threadCubit})
      : _threadCubit = threadCubit,
        super(ChatState.loading()) {
    on<RetryEvent>((_, emit) => _retry(emit));
    on<FetchMessagesEvent>((event, emit) => _fetchMessages(emit),
        transformer: droppable());
    on<_ThreadChangeEvent>((event, emit) => _switchThread(emit));
    _threadCubit.stream.listen((event) => add(_ThreadChangeEvent()));
    add(_ThreadChangeEvent());
  }

  Stream<Iterable<Message>> get _newMessageStream {
    return _gqlClient
        .stream(GGetNewMessagesReq(
            (q) => q..vars.threadId = _threadCubit.state.thread?.id))
        .map((resp) => resp.messages.map((data) => Message(
              user: User(
                  id: data.user.id,
                  name: data.user.name,
                  profilePictureUrl: data.user.profile_picture),
              id: data.id,
              message: data.message,
              isImage: data.is_image,
              createdAt: data.created_at,
              updatedAt: data.updated_at ?? data.created_at,
            )));
  }

  Future<void> _fetchMessages(Emitter<ChatState> emit) async {
    GQueryMessagesInThreadData resp;

    final before = state.join((fm) => fm.messages.last.createdAt, (_) => null,
            (_) => null, (_) => null) ??
        clock.hoursFromNow(5);

    try {
      resp = await _gqlClient.request(GQueryMessagesInThreadReq((q) => q
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.before = before
        ..vars.threadId = _threadCubit.state.thread?.id));
    } on Failure catch (f) {
      emit(ChatState.failure(f));
      return;
    }

    final chats = resp.messages
        .map((message) => Message(
            isImage: message.is_image,
            updatedAt: message.updated_at ?? message.created_at,
            id: message.id,
            user: User(
                name: message.user.name,
                profilePictureUrl: message.user.profile_picture,
                id: message.user.id),
            message: message.message,
            createdAt: message.created_at))
        .toList();

    final List<Message> oldMessages =
        state.join((fm) => fm.messages, (_) => [], (_) => [], (_) => []);

    final hasReachedMax = chats.length < SINGLE_QUERY_LIMIT;

    emit(ChatState.fetchedMessages(FetchedMessages(
        messages: _combineMessages(oldMessages, chats),
        hasReachedMax: hasReachedMax)));
  }

  Future<void> _switchThread(Emitter<ChatState> emit) async {
    final newThread = _threadCubit.state.thread;
    emit(ChatState.loading());

    if (newThread == null) {
      emit(ChatState.noThread());
      return;
    }

    await _subscription?.cancel();
    _subscription = _newMessageStream.listen(_onNewMessage);

    await _fetchMessages(emit);
  }

  Future<void> _retry(Emitter<ChatState> emit) async {
    await _switchThread(emit);
  }

  void _onNewMessage(Iterable<Message> messages) {
    final fm = state.join((fm) => fm, (_) => null, (_) => null, (_) => null);

    if (appendingNewMessages) {
      emit(ChatState.fetchedMessages(FetchedMessages(
          messages: _combineMessages(messages, fm?.messages ?? []),
          bottomFetchState: fm?.bottomFetchState ?? EdgeFetchState.NotFetching,
          topFetchState: fm?.topFetchState ?? EdgeFetchState.NotFetching)));
    }
  }

  List<Message> _combineMessages(
          Iterable<Message> oldMessages, Iterable<Message> newMessages) =>
      List.from({...oldMessages, ...newMessages})
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
