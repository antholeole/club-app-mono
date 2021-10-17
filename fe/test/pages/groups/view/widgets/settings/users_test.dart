import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/pages/groups/view/widgets/settings/users.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';

import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeClub = Club(admin: false, id: UuidType.generate(), name: 'blah');
  final mockUsers = [
    User(name: 'fakeme', id: UuidType.generate()),
    User(name: 'fkae2', id: UuidType.generate())
  ];

  setUp(() {
    registerAllMockServices();
  });

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
        .pumpApp(Provider<Club>(create: (_) => fakeClub, child: const Users()));

    await tester.pump();

    expect(find.byType(UserTile), findsNWidgets(mockUsers.length));
  });
  testWidgets('should display error text on error', (tester) async {
    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<AuthGqlClient>(),
        error: (_) => Failure(status: FailureStatus.NoConn));

    await tester
        .pumpApp(Provider<Club>(create: (_) => fakeClub, child: const Users()));

    await tester.pump();

    expect(find.text(Users.ERROR_LOADING_USERS), findsOneWidget);
  });
}
