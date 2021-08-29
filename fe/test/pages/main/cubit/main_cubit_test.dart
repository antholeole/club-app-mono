import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.var.gql.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  const errorMessage = 'im an errro';
  final fakeGroup1 =
      Group(id: UuidType.generate(), name: 'fake group1', admin: false);

  setUpAll(() {
    FakeRequest.registerOfType<GQuerySelfGroupsPreviewData,
        GQuerySelfGroupsPreviewVars>();
  });

  setUp(() {
    registerAllMockServices();
  });

  group('set group', () {
    blocTest<MainCubit, MainState>('should emit new group',
        build: () => MainCubit(),
        act: (cubit) => cubit.setGroup(fakeGroup1),
        expect: () => [MainState.withGroup(fakeGroup1)]);
  });

  group('log out', () {
    blocTest<MainCubit, MainState>(
        'should clear local data and logout with no error on no error',
        setUp: () {
          when(() => getIt<LocalFileStore>().delete(LocalStorageType.LocalUser))
              .thenAnswer((_) async => null);

          when(() => getIt<FlutterSecureStorage>().deleteAll())
              .thenAnswer((_) async => null);

          when(() => getIt<TokenManager>().delete())
              .thenAnswer((_) async => null);
        },
        build: () => MainCubit(),
        act: (cubit) => cubit.logOut(),
        expect: () => [MainState.logOut()],
        verify: (c) => [
              () => getIt<LocalFileStore>().delete(LocalStorageType.LocalUser),
              getIt<FlutterSecureStorage>().deleteAll,
              getIt<TokenManager>().delete
            ].forEach((fn) => verify(() => fn()).called(1)));

    blocTest<MainCubit, MainState>(
        'should clear local data and logout with error on error',
        setUp: () {
          when(() => getIt<LocalFileStore>().delete(LocalStorageType.LocalUser))
              .thenAnswer((_) async => null);

          when(() => getIt<FlutterSecureStorage>().deleteAll())
              .thenAnswer((_) async => null);

          when(() => getIt<TokenManager>().delete())
              .thenAnswer((_) async => null);
        },
        build: () => MainCubit(),
        act: (cubit) => cubit.logOut(withError: errorMessage),
        expect: () => [MainState.logOut(withError: errorMessage)],
        verify: (c) => [
              () => getIt<LocalFileStore>().delete(LocalStorageType.LocalUser),
              getIt<FlutterSecureStorage>().deleteAll,
              getIt<TokenManager>().delete
            ].forEach((fn) => verify(() => fn()).called(1)));
  });

  group('initalize main page', () {
    final userId = UuidType.generate();
    const fatalFailure =
        Failure(status: FailureStatus.RefreshFail, message: 'i am fatal');

    setUp(() {
      when(() => getIt<LocalUserService>().getLoggedInUserId())
          .thenAnswer((_) async => userId);
    });

    blocTest<MainCubit, MainState>('should emit failure on fatal error',
        setUp: () {
          stubGqlResponse<GQuerySelfGroupsPreviewData,
                  GQuerySelfGroupsPreviewVars>(getIt<AuthGqlClient>(),
              error: (_) => fatalFailure);
        },
        build: () => MainCubit(),
        act: (cubit) => cubit.initalizeMainPage(),
        expect: () => [MainState.loadFailure(fatalFailure)]);

    blocTest<MainCubit, MainState>('should query from cache on non-fatal error',
        setUp: () {
          stubGqlResponse<GQuerySelfGroupsPreviewData,
                  GQuerySelfGroupsPreviewVars>(getIt<AuthGqlClient>(),
              requestMatcher: isA<
                      OperationRequest<GQuerySelfGroupsPreviewData,
                          GQuerySelfGroupsPreviewVars>>()
                  .having((req) => req.fetchPolicy, 'fetch policy',
                      equals(FetchPolicy.NetworkOnly)),
              error: (_) => const Failure(
                  status: FailureStatus.GQLMisc, message: 'i am not fatal'));

          stubGqlResponse<GQuerySelfGroupsPreviewData,
                  GQuerySelfGroupsPreviewVars>(getIt<AuthGqlClient>(),
              requestMatcher: isA<
                      OperationRequest<GQuerySelfGroupsPreviewData,
                          GQuerySelfGroupsPreviewVars>>()
                  .having((req) => req.fetchPolicy, 'fetch policy',
                      equals(FetchPolicy.CacheOnly)),
              data: (_) =>
                  GQuerySelfGroupsPreviewData.fromJson({'user_to_group': []})!);
        },
        build: () => MainCubit(),
        act: (cubit) => cubit.initalizeMainPage(),
        expect: () => [MainState.groupless()],
        verify: (_) => verify(() => getIt<AuthGqlClient>().request(any(
            that: isA<
                    OperationRequest<GQuerySelfGroupsPreviewData,
                        GQuerySelfGroupsPreviewVars>>()
                .having((req) => req.fetchPolicy, 'fetch policy',
                    equals(FetchPolicy.CacheOnly))))).called(1));

    blocTest<MainCubit, MainState>(
      'should emit first group on multiple groups',
      setUp: () {
        stubGqlResponse<GQuerySelfGroupsPreviewData,
                GQuerySelfGroupsPreviewVars>(getIt<AuthGqlClient>(),
            data: (_) => GQuerySelfGroupsPreviewData.fromJson({
                  'user_to_group': [
                    {
                      'group': {
                        'id': fakeGroup1.id.toString(),
                        'group_name': fakeGroup1.name
                      },
                      'admin': fakeGroup1.admin
                    },
                    {
                      'group': {
                        'id': 'b454d579-c4d2-403c-95cd-ac8dbc97476a',
                        'group_name': 'Sports Ball Team'
                      },
                      'admin': true
                    }
                  ]
                })!);
      },
      build: () => MainCubit(),
      act: (cubit) {
        cubit.initalizeMainPage();
      },
      expect: () => [MainState.withGroup(fakeGroup1)],
    );

    blocTest<MainCubit, MainState>(
      'should emit groupless on no group',
      setUp: () {
        stubGqlResponse<GQuerySelfGroupsPreviewData,
                GQuerySelfGroupsPreviewVars>(getIt<AuthGqlClient>(),
            data: (_) =>
                GQuerySelfGroupsPreviewData.fromJson({'user_to_group': []})!);
      },
      build: () => MainCubit(),
      act: (cubit) {
        cubit.initalizeMainPage();
      },
      expect: () => [MainState.groupless()],
    );
  });
}
