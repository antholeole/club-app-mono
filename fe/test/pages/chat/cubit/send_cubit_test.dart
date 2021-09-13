import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/thread.dart';
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

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
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

    blocTest<SendCubit, List<SendState>>(
      'should throw failure on no thread selected',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.noThread());
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) async {
        await cubit.send('hi');
      },
      expect: () => [
        contains(isA<SendState>().having(
            (ss) => ss.join((_) => null, (fs) => fs),
            'failure state',
            isA<FailureSending>().having((fs) => fs.failure.message,
                'failure message', SendCubit.NO_THREAD_SELECTED_COPY)))
      ],
    );

    //should throw error on no thread selected
    //should have loading state
    //should switch to sent state when message sent
  });

  //should clear all sending messages on switch thread
}
