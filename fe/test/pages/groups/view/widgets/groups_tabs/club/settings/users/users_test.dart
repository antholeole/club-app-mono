import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/users.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/shared_widgets/user_tile.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';

import 'package:collection/collection.dart';

import 'package:fe/gql/query_roles_in_group.var.gql.dart';
import 'package:fe/gql/query_roles_in_group.req.gql.dart';
import 'package:fe/gql/query_roles_in_group.data.gql.dart';

import '../../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../../test_helpers/pump_app.dart';
import '../../../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeClub = Club(admin: false, id: UuidType.generate(), name: 'blah');
  final mockUsers = [
    User(name: 'fakeme', id: UuidType.generate()),
    User(name: 'fkae2', id: UuidType.generate())
  ];

  final mockUserRoles = [
    [
      Role(id: UuidType.generate(), name: 'user 1 role 1'),
      Role(id: UuidType.generate(), name: 'user 1 role 2'),
    ],
    [
      Role(id: UuidType.generate(), name: 'user 2 role 1'),
      Role(id: UuidType.generate(), name: 'user 2 role 2'),
      Role(id: UuidType.generate(), name: 'user 2 role 3'),
    ]
  ];

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child, required Club group}) {
    return MultiProvider(providers: [
      Provider.value(value: group),
      Provider(
          create: (_) =>
              UserCubit(User(name: 'asdasdasd', id: UuidType.generate())))
    ], child: child);
  }

  testWidgets('should display user tile for each user', (tester) async {
    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GQueryUsersInGroupData.fromJson({
              'user_to_group': mockUsers
                  .map((e) => {
                        'user': {'name': e.name, 'id': e.id.uuid}
                      })
                  .toList()
            })!);

    await tester
        .pumpApp(wrapWithDependencies(child: const Users(), group: fakeClub));
    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();

    expect(find.byType(UserTile), findsNWidgets(mockUsers.length));
  });

  testWidgets('should display error text on error', (tester) async {
    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<AuthGqlClient>(),
        error: (_) => Failure(status: FailureStatus.NoConn));

    await tester
        .pumpApp(wrapWithDependencies(child: const Users(), group: fakeClub));
    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();

    expect(find.text(Users.ERROR_LOADING_USERS), findsOneWidget);
  });

  group('on group admin', () {
    final fakeAdminClub =
        Club(admin: true, id: UuidType.generate(), name: 'blah');

    setUp(() {
      stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
          getIt<AuthGqlClient>(),
          requestMatcher: isA<GQueryUsersInGroupReq>(),
          data: (_) => GQueryUsersInGroupData.fromJson({
                'user_to_group': mockUsers
                    .mapIndexed((i, e) => {
                          'user': {
                            'name': e.name,
                            'id': e.id.uuid,
                            'user_to_roles': mockUserRoles[i]
                                .map((role) => {
                                      'role': {
                                        'name': role.name,
                                        'id': role.id.uuid
                                      }
                                    })
                                .toList()
                          }
                        })
                    .toList()
              })!);
    });

    testWidgets('should call all roles API once', (tester) async {
      stubGqlResponse<GQueryRolesInGroupData, GQueryRolesInGroupVars>(
          getIt<AuthGqlClient>(),
          requestMatcher: isA<GQueryRolesInGroupReq>(),
          data: (_) => GQueryRolesInGroupData.fromJson({'roles': []})!);

      await tester.pumpApp(
          wrapWithDependencies(child: const Users(), group: fakeAdminClub));
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(
          verify(() => getIt<AuthGqlClient>().request(captureAny(
              that: isA<
                  OperationRequest<GQueryRolesInGroupData,
                      GQueryRolesInGroupVars>>()))).captured.length,
          1);
    });
  });
}
