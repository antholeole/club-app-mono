import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_bloc_stream.dart';
import '../../../test_helpers/stub_gql_response.dart';
import 'package:fe/gql/insert_message.data.gql.dart';
import 'package:fe/gql/insert_message.var.gql.dart';
import 'package:fe/gql/insert_message.req.gql.dart';

void main() {
  final MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
  final MockChatBloc mockChatBloc = MockChatBloc.getMock();

  final fakeThread = Thread(id: UuidType.generate(), name: 'asdsad');
  final fakeUserId = UuidType.generate();

  const messageStr = 'asdas';

  setUp(() {
    registerAllMockServices();
  });

  blocTest<SendCubit, List<SendState>>('should add sending state on send',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));
        whenListen<ChatState>(mockChatBloc, const Stream.empty());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GInsertMessageData.fromJson({})!);
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) {
        cubit.send(messageStr);
      },
      expect: () => [
            contains(isA<SendState>().having(
                (state) => state.join((p0) => p0, (p0) => null),
                'state',
                isA<Sending>().having((sending) => sending.message.message,
                    'message', messageStr))),
            []
          ],
      verify: (_) {
        verify(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GInsertMessageReq>()))).called(1);
      });

  blocTest<SendCubit, List<SendState>>(
      'should emit sending failure on send failure',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));
        whenListen<ChatState>(mockChatBloc, const Stream.empty());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            error: (_) => Failure(status: FailureStatus.GQLMisc));
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) {
        cubit.send(messageStr);
      },
      expect: () => [
            anything,
            contains(isA<SendState>().having(
                (state) => state.join((_) => null, (p0) => p0),
                'state',
                isA<FailureSending>().having((sending) => sending.failure,
                    'failure', Failure(status: FailureStatus.GQLMisc)))),
          ]);

  blocTest<SendCubit, List<SendState>>('should try resending on send failure',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));
        whenListen<ChatState>(mockChatBloc, const Stream.empty());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            error: (_) => Failure(status: FailureStatus.GQLMisc));
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        final failure = cubit.stream.skip(1).first;

        await cubit.send(messageStr);

        await (await failure).first.join((p0) => null, (p0) => p0)!.resend();
      },
      expect: () => [anything, anything, anything, anything],
      verify: (_) {
        verify(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GInsertMessageReq>()))).called(2);
      });

  late StreamController<ChatState> sendingController;
  blocTest<SendCubit, List<SendState>>(
      'should remove send state on success sending',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));
        sendingController = stubBlocStream<ChatState>(mockChatBloc,
            initialState: ChatState.loading());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GInsertMessageData.fromJson({})!);
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        final emitted = cubit.stream.first;
        await cubit.send(messageStr);

        sendingController
            .add(ChatState.fetchedMessages(FetchedMessages(messages: [
          Message(
              user: User(id: fakeUserId, name: 'asdasd'),
              id: (await emitted).first.message.id,
              message: messageStr,
              isImage: false,
              createdAt: clock.now(),
              updatedAt: clock.now())
        ])));

        await Future.delayed(const Duration(milliseconds: 5));
      },
      expect: () => [
            contains(isA<SendState>().having(
                (state) => state.join((p0) => p0, (p0) => null),
                'state',
                isA<Sending>().having((sending) => sending.message.message,
                    'message', messageStr))),
            []
          ],
      verify: (_) {
        verify(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GInsertMessageReq>()))).called(1);
      });

  late StreamController<ThreadState> threadController;
  blocTest<SendCubit, List<SendState>>(
      'should remove send state on switch thread',
      setUp: () {
        threadController = stubBlocStream<ThreadState>(mockThreadCubit,
            initialState: ThreadState.thread(fakeThread));
        whenListen<ChatState>(mockChatBloc, const Stream.empty());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GInsertMessageData.fromJson({})!);
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        await cubit.send(messageStr);

        threadController.add(ThreadState.thread(
            Thread(id: UuidType.generate(), name: 'asdoaisndaois new thread')));

        await Future.delayed(const Duration(milliseconds: 5));
      },
      expect: () => [
            contains(isA<SendState>().having(
                (state) => state.join((p0) => p0, (p0) => null),
                'state',
                isA<Sending>().having((sending) => sending.message.message,
                    'message', messageStr))),
            [],
            [] //cleanup
          ],
      verify: (_) {
        verify(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GInsertMessageReq>()))).called(1);
      });
}
