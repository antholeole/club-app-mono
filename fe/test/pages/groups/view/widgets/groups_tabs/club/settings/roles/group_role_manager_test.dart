import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/roles/group_role_manager.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../../test_helpers/pump_app.dart';

import 'package:fe/gql/add_role_to_group.req.gql.dart';
import 'package:fe/gql/add_role_to_group.var.gql.dart';
import 'package:fe/gql/add_role_to_group.data.gql.dart';

import 'package:fe/gql/query_roles_in_group_with_join_code.req.gql.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.data.gql.dart';

import '../../../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeClub = Club(id: UuidType.generate(), name: 'fkasdasd', admin: true);

  GQueryRolesInGroupWithJoinCodeData buildData(
      Map<Role, String?> roleToJoinCode) {
    final jsons = [];

    roleToJoinCode.forEach((role, joinCode) => jsons.add({
          'name': role.name,
          'id': role.id.uuid,
          'join_token': {'token': joinCode}
        }));

    return GQueryRolesInGroupWithJoinCodeData.fromJson({'roles': jsons})!;
  }

  setUpAll(() {
    registerFallbackValue(GAddRoleToGroupReq((r) => r
      ..vars.groupId = UuidType.generate()
      ..vars.roleName = 'asdasd'));
  });

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return MultiProvider(
      providers: [
        Provider.value(value: fakeClub),
      ],
      child: child,
    );
  }

  testWidgets('should display all inital roles', (tester) async {
    final initalRole = Role(name: 'BC', id: UuidType.generate());
    const initalRoleJoinCode = '1231231231313312313';

    stubGqlResponse(getIt<AuthGqlClient>(),
        data: (_) => buildData({initalRole: initalRoleJoinCode}));

    await tester.pumpApp(wrapWithDependencies(child: const GroupRoleManager()));

    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();

    expect(find.text(initalRole.name), findsOneWidget);
    expect(find.textContaining(initalRoleJoinCode), findsOneWidget);
  });

  testWidgets('should prompt on addroles click', (tester) async {
    final initalRole = Role(name: 'BC', id: UuidType.generate());
    const initalRoleJoinCode = '1231231231313312313';

    stubGqlResponse(getIt<AuthGqlClient>(),
        data: (_) => buildData({initalRole: initalRoleJoinCode}));

    await tester.pumpApp(wrapWithDependencies(child: const GroupRoleManager()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text(GroupRoleManager.NEW_ROLE_PROMPT_COPY), findsOneWidget);
  });

  testWidgets('should call api on new role add', (tester) async {
    const newRoleName = 'NWE ROLE NEW ROLE NEW';

    stubGqlResponse(getIt<AuthGqlClient>(),
        data: (_) => buildData({}),
        requestMatcher: isA<GQueryRolesInGroupWithJoinCodeReq>());

    when(() => getIt<AuthGqlClient>()
            .mutateFromUi<GAddRoleToGroupData, GAddRoleToGroupVars>(
          any(),
          any(),
          errorMessage: any(named: 'errorMessage'),
          successMessage: any(named: 'successMessage'),
          onComplete: any(named: 'onComplete'),
        )).thenAnswer((_) async => null);

    stubGqlResponse(getIt<AuthGqlClient>(),
        data: (_) => buildData({}), requestMatcher: isA<GAddRoleToGroupReq>());

    await tester.pumpApp(wrapWithDependencies(child: const GroupRoleManager()));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(PlatformTextField), newRoleName);
    await tester.tap(find.text(GroupRoleManager.ADD_NEW_ROLE_BUTTON_COPY));
    await tester.pumpAndSettle();

    expect(
        (verify(() => getIt<AuthGqlClient>()
                    .mutateFromUi<GAddRoleToGroupData, GAddRoleToGroupVars>(
                        captureAny(that: isA<GAddRoleToGroupReq>()), any(),
                        errorMessage: any(named: 'errorMessage'),
                        successMessage: any(named: 'successMessage'),
                        onComplete: any(named: 'onComplete'))).captured.first
                as GAddRoleToGroupReq)
            .vars
            .roleName,
        newRoleName);
  });
}
