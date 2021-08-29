import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/profile/cubit/name_change_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/update_self_name.data.gql.dart';
import 'package:fe/gql/update_self_name.req.gql.dart';
import 'package:fe/gql/update_self_name.var.gql.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  const newName = 'newName';
  final userId = UuidType.generate();
  final caller = MockCaller();

  setUpAll(() {
    registerFallbackValue(
        FakeRequest<GUpdateSelfNameData, GUpdateSelfNameVars>());
  });

  setUp(() {
    registerAllMockServices();

    reset(caller);

    when(() => getIt<LocalUserService>().getLoggedInUserId())
        .thenAnswer((_) async => userId);
  });

  group('change name', () {
    blocTest<NameChangeCubit, NameChangeState>(
        'should emit failure on regex fail',
        build: () => NameChangeCubit(),
        act: (cubit) => cubit.changeName(newName + ']', caller.call),
        expect: () => [
              NameChangeState.changing(),
              NameChangeState.failure(const Failure(
                  status: FailureStatus.RegexFail,
                  message: NameChangeCubit.REGEX_FAIL_COPY))
            ],
        verify: (_) => verifyNever(() => caller.call()));

    blocTest<NameChangeCubit, NameChangeState>(
        'should emit failure on http call fail',
        setUp: () {
          stubGqlResponse<GUpdateSelfNameData, GUpdateSelfNameVars>(
              getIt<AuthGqlClient>(),
              error: (_) => const Failure(status: FailureStatus.GQLMisc));
        },
        build: () => NameChangeCubit(),
        act: (cubit) => cubit.changeName(newName, caller.call),
        expect: () => [
              NameChangeState.changing(),
              NameChangeState.failure(
                  const Failure(status: FailureStatus.GQLMisc))
            ],
        verify: (_) => verifyNever(() => caller.call()));

    blocTest<NameChangeCubit, NameChangeState>(
        'should call on complete callback and save changes on complete',
        setUp: () {
          when(() => getIt<LocalUserService>().saveChanges(any()))
              .thenAnswer((_) async => null);

          stubGqlResponse<GUpdateSelfNameData, GUpdateSelfNameVars>(
              getIt<AuthGqlClient>(),
              data: (invoc) => GUpdateSelfNameData.fromJson({
                    'update_users_by_pk': {
                      'name':
                          (invoc.positionalArguments[0] as GUpdateSelfNameReq)
                              .vars
                              .name
                    }
                  })!);
        },
        build: () => NameChangeCubit(),
        act: (cubit) => cubit.changeName(newName, caller.call),
        expect: () =>
            [NameChangeState.changing(), NameChangeState.notChanging()],
        verify: (_) => verify(() => caller.call()).called(1));
  });
}
