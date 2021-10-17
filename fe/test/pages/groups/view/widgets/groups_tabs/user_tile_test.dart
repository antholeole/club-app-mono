import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/get_or_create_dm.data.gql.dart';
import 'package:fe/gql/get_or_create_dm.var.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeUser = User(id: UuidType.generate(), name: 'asdasd');
  final mockMainCubit = MockMainCubit.getMock();

  setUpAll(() {
    registerFallbackValue(Dm(id: UuidType.generate(), users: []));
  });

  setUp(() {
    registerAllMockServices();
  });

  Widget build({required Widget child}) {
    return BlocProvider<MainCubit>(create: (_) => mockMainCubit, child: child);
  }

  testWidgets('should set DM on tap dm button', (tester) async {
    stubGqlResponse<GGetOrCreateDmData, GGetOrCreateDmVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GGetOrCreateDmData.fromJson({
              'get_or_create_dm': {
                'name': 'blah',
                'id': UuidType.generate().uuid
              }
            })!);

    await tester.pumpApp(build(child: UserTile(user: fakeUser)));
    await tester.tap(find.byIcon(Icons.chat_outlined));

    verify(() => getIt<AuthGqlClient>().request(any())).called(1);
    verify(() => mockMainCubit.setDm(any())).called(1);
  });

  testWidgets('should call handler on handle failure', (tester) async {
    stubGqlResponse<GGetOrCreateDmData, GGetOrCreateDmVars>(
        getIt<AuthGqlClient>(),
        error: (_) => Failure(status: FailureStatus.GQLMisc));

    await tester.pumpApp(build(child: UserTile(user: fakeUser)));
    await tester.tap(find.byIcon(Icons.chat_outlined));

    verify(() => getIt<Handler>().handleFailure(any(), any())).called(1);
    verifyNever(() => mockMainCubit.setDm(any()));
  });
}
