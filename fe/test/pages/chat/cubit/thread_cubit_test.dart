import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final Dm fakeDm = Dm(id: UuidType.generate(), users: []);
  final Club fakeClub =
      Club(id: UuidType.generate(), name: 'micky', admin: false);
  final fakeThread = Thread(name: 'micky 2.0', id: UuidType.generate());

  final fakeUserId = UuidType.generate();

  setUp(() {
    registerAllMockServices();

    when(() => getIt<LocalUserService>().getLoggedInUserId())
        .thenAnswer((_) async => fakeUserId);
  });

  blocTest<ThreadCubit, ThreadState>(
      'switch to thread should emit switched thread',
      build: () => ThreadCubit(group: fakeDm),
      act: (cubit) => cubit.switchToThread(fakeThread));

  blocTest<ThreadCubit, ThreadState>('new group to DM should not call API',
      build: () => ThreadCubit(group: fakeDm),
      verify: (_) => verifyNever(() => getIt<AuthGqlClient>()
          .request(any(that: isA<GQuerySelfThreadsInGroupReq>()))));

  blocTest<ThreadCubit, ThreadState>(
      'should emit first thread if api returns thread',
      setUp: () {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'threads': [
                    fakeThread.toJson(),
                    {
                      'name': 'thread2',
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!);
      },
      build: () => ThreadCubit(group: fakeClub),
      expect: () => [ThreadState.thread(fakeThread)]);

  blocTest<ThreadCubit, ThreadState>(
      'should emit no thread if api returns no thread',
      setUp: () {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({})!);
      },
      build: () => ThreadCubit(group: fakeClub),
      expect: () => [ThreadState.noThread()]);

  blocTest<ThreadCubit, ThreadState>('should emit no thread on api failure',
      setUp: () {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            error: (_) =>
                Failure(status: FailureStatus.Custom, message: 'asds'));
      },
      build: () => ThreadCubit(group: fakeClub),
      expect: () => [ThreadState.noThread()]);
}
