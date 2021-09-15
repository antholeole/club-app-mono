import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/insert_message.data.gql.dart';
import 'package:fe/gql/insert_message.var.gql.dart';
import 'package:fe/gql/insert_message.req.gql.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/stub_cubit_stream.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final mockThreadCubit = MockThreadCubit.getMock();
  final mockChatBloc = MockChatBloc.getMock();

  final fakeUserId = UuidType.generate();
  final fakeThread = Thread(name: 'thread', id: UuidType.generate());

  setUp(() {
    registerAllMockServices();

    when(() => getIt<LocalUserService>().getLoggedInUserId())
        .thenAnswer((_) async => fakeUserId);
  });

  tearDown(() {
    resetMockBloc(mockThreadCubit);
    resetMockBloc(mockChatBloc);
  });

  group('send', () {
    blocTest<SendCubit, List<SendState>>('should allow resend on failure',
        setUp: () {
          whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
              initialState: ThreadState.thread(fakeThread));

          stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
              getIt<AuthGqlClient>(),
              error: (_) => const Failure(status: FailureStatus.GQLMisc));
        },
        build: () =>
            SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
        act: (cubit) async {
          await cubit.send('hi');

          await cubit.state
              .firstWhere((element) => element.join((e) => false, (fs) => true))
              .join((_) => null, (fs) => fs)!
              .resend();
        },
        verify: (_) {
          verify(() => getIt<AuthGqlClient>().request(any())).called(2);
        });

    //must be last! floating future must cancel itself.
    blocTest<SendCubit, List<SendState>>(
      'should have loading and success state',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));

        whenListen<ChatState>(mockChatBloc, const Stream.empty(),
            initialState:
                ChatState.fetchedMessages(const FetchedMessages(messages: [])));

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GInsertMessageData.fromJson({
                  'insert_messages': {
                    'returning': [
                      {'created_at': '2021-09-13T22:50:38.454219+00:00'}
                    ]
                  }
                })!);
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        await cubit.send('hi');
        await cubit.close();
      },
      expect: () => [
        contains(isA<SendState>().having(
            (ss) => ss.join((ss) => ss, (_) => null),
            'sending state',
            isA<Sending>())),
      ],
    );

    late UuidType inputMsgId;
    late StreamController<ChatState> chatStateController;
    blocTest<SendCubit, List<SendState>>(
      'should switch to sent state when recieve message with same ID',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(), data: (invocation) {
          inputMsgId = (invocation.positionalArguments[0] as GInsertMessageReq)
              .vars
              .messageId;

          chatStateController = stubBlocStream(mockChatBloc);

          return GInsertMessageData.fromJson({
            'insert_messages': {
              'returning': [
                {'created_at': '2021-09-13T22:50:38.454219+00:00'}
              ]
            }
          })!;
        });
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        await cubit.send('hi');

        chatStateController
            .add(ChatState.fetchedMessages(FetchedMessages(messages: [
          Message(
              user: User(name: 'a', id: UuidType.generate()),
              id: inputMsgId,
              message: 'asdasd',
              isImage: false,
              createdAt: clock.now(),
              updatedAt: clock.now())
        ])));

        await Future.delayed(const Duration(milliseconds: 5));
      },
      expect: () => [
        contains(isA<SendState>().having(
            (ss) => ss.join((ss) => ss, (_) => null),
            'sending state',
            isA<Sending>())),
        []
      ],
    );
  });

  //should clear all sending messages on switch thread
}
