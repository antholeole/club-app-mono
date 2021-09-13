import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_messages_in_thread.var.gql.dart';
import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';
import 'package:fe/gql/get_new_messages.req.gql.dart';
import 'package:fe/gql/get_new_messages.data.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/stub_cubit_stream.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final mockThreadCubit = MockThreadCubit.getMock();
  final fakeThread = Thread(name: 'fake', id: UuidType.generate());
  late StreamController<ThreadState> mockThreadCubitController;

  setUp(() {
    mockThreadCubitController = stubCubitStream<ThreadState>(mockThreadCubit,
        initialState: ThreadState.noThread());
    registerAllMockServices();
  });

  tearDown(() {
    resetMockBloc(mockThreadCubit);
  });

  group('switch thread', () {
    blocTest<ChatBloc, ChatState>('should call fetch messages API',
        setUp: () {
          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
              data: (_) =>
                  GQueryMessagesInThreadData.fromJson({'messages': []})!);

          when(() => getIt<AuthGqlClient>()
                  .stream(any(that: isA<GGetNewMessagesReq>())))
              .thenAnswer(
                  (invocation) => const Stream<GGetNewMessagesData>.empty());
        },
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (_) =>
            mockThreadCubitController.add(ThreadState.thread(fakeThread)),
        expect: () => [
              ChatState.loading(),
              ChatState.fetchedMessages(
                  const FetchedMessages(messages: [], hasReachedMax: true)),
            ],
        verify: (_) {
          verify(() => getIt<AuthGqlClient>().request(any(
              that: isA<GQueryMessagesInThreadReq>().having(
                  (req) => req.vars.threadId,
                  'thread id',
                  equals(fakeThread.id))))).called(1);
          verify(() => getIt<AuthGqlClient>().stream(any(
              that: isA<GGetNewMessagesReq>().having((req) => req.vars.threadId,
                  'thread id', equals(fakeThread.id))))).called(1);
        });

    blocTest('should switch to no thread if thread === null',
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (_) => mockThreadCubitController.add(ThreadState.noThread()),
        expect: () => [ChatState.loading(), ChatState.noThread()]);
  });

  group('retry', () {
    blocTest<ChatBloc, ChatState>('should retry request',
        setUp: () {
          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
              error: (_) => const Failure(status: FailureStatus.GQLMisc));

          when(() => getIt<AuthGqlClient>()
                  .stream(any(that: isA<GGetNewMessagesReq>())))
              .thenAnswer(
                  (invocation) => const Stream<GGetNewMessagesData>.empty());
        },
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (bloc) {
          bloc.add(const FetchMessagesEvent());
          bloc.add(const RetryEvent());
        },
        verify: (_) => verify(() => getIt<AuthGqlClient>().request(any(
            that: isA<GQueryMessagesInThreadReq>().having(
                (req) => req.vars.threadId,
                'thread id',
                equals(fakeThread.id))))).called(2));
  });

  group('fetch messages', () {
    var twentyMsg = [
      for (var i = 0; i < 20; i++)
        Message(
            user: User(
                id: UuidType.generate(),
                name: 'asda',
                profilePictureUrl: 'asdas'),
            id: UuidType.generate(),
            message: 'msg',
            isImage: false,
            createdAt: clock.now(),
            updatedAt: clock.now())
    ];

    blocTest<ChatBloc, ChatState>(
        'should return with hasReachedMax = false if returning 20',
        setUp: () => stubGqlResponse<GQueryMessagesInThreadData,
                GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
            data: (_) => GQueryMessagesInThreadData.fromJson(
                {'messages': twentyMsg.map((e) => e.toJson()).toList()})!),
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (bloc) => bloc.add(const FetchMessagesEvent()),
        expect: () => [
              isA<ChatState>().having(
                  (cs) => cs.join(
                      (fm) => fm, (_) => null, (_) => null, (_) => null),
                  'state',
                  isA<FetchedMessages>()
                      .having((fm) => fm.hasReachedMax, 'hasReachedMax', false)
                      .having((fm) => fm.messages.length, 'message len', 20))
            ]);

    blocTest<ChatBloc, ChatState>(
        'should be able to fetch exactly 20 then 0 messages',
        setUp: () {
          final responseData = [
            GQueryMessagesInThreadData.fromJson(
                {'messages': twentyMsg.map((e) => e.toJson()).toList()})!,
            GQueryMessagesInThreadData.fromJson({'messages': []})!
          ];

          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
              data: (_) => responseData.removeAt(0));
        },
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (bloc) {
          bloc.add(const FetchMessagesEvent());
          bloc.add(const FetchMessagesEvent());
        },
        expect: () => [
              isA<ChatState>().having(
                  (cs) => cs.join(
                      (fm) => fm, (_) => null, (_) => null, (_) => null),
                  'state',
                  isA<FetchedMessages>()
                      .having((fm) => fm.hasReachedMax, 'hasReachedMax', false)
                      .having((fm) => fm.messages.length, 'message len', 20)),
              isA<ChatState>().having(
                  (cs) => cs.join(
                      (fm) => fm, (_) => null, (_) => null, (_) => null),
                  'state',
                  isA<FetchedMessages>()
                      .having((fm) => fm.hasReachedMax, 'hasReachedMax', true)),
            ]);

    final hoursAgo = clock.hoursAgo(50);
    blocTest<ChatBloc, ChatState>(
        'should query with previous fetches earliest message',
        setUp: () {
          final newMessages = twentyMsg.sublist(1);
          newMessages.add(Message(
              user: User(
                  id: UuidType.generate(),
                  name: 'asda',
                  profilePictureUrl: 'asdas'),
              id: UuidType.generate(),
              message: 'msg',
              isImage: false,
              createdAt: hoursAgo,
              updatedAt: clock.now()));

          final responseData = [
            GQueryMessagesInThreadData.fromJson(
                {'messages': newMessages.map((e) => e.toJson()).toList()})!,
            GQueryMessagesInThreadData.fromJson({'messages': []})!
          ];

          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
              data: (_) => responseData.removeAt(0));
        },
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (bloc) {
          bloc.add(const FetchMessagesEvent());
          bloc.add(const FetchMessagesEvent());
        },
        verify: (_) => verify(() => getIt<AuthGqlClient>().request(any(
            that: isA<GQueryMessagesInThreadReq>().having(
                (req) => req.vars.before, 'before', hoursAgo)))).called(1));

    blocTest<ChatBloc, ChatState>('should emit failure on failure fetching',
        setUp: () => stubGqlResponse<GQueryMessagesInThreadData,
                GQueryMessagesInThreadVars>(getIt<AuthGqlClient>(),
            error: (_) => const Failure(status: FailureStatus.GQLMisc)),
        build: () => ChatBloc(threadCubit: mockThreadCubit),
        act: (bloc) => bloc.add(const FetchMessagesEvent()),
        expect: () =>
            [ChatState.failure(const Failure(status: FailureStatus.GQLMisc))]);
  });

  //todo test emitting new messages when they fix breakpoints.....
}
