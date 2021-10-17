import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/club_settings.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/join_token_tile.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';
import 'package:provider/provider.dart';

import '../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../test_helpers/pump_app.dart';
import '../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeClubAdmin = Club(id: UuidType.generate(), name: 'hi', admin: true);
  final fakeClubNotAdmin =
      Club(id: UuidType.generate(), name: 'hi 2', admin: false);

  setUp(() {
    registerAllMockServices();

    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GQueryUsersInGroupData.fromJson({})!);
  });

  testWidgets('should display joinTokenTile if admin', (tester) async {
    await tester.pumpApp(Column(
      children: [
        Provider(
          create: (_) => fakeClubAdmin,
          child: const GroupSettings(),
        ),
        Provider(
          create: (_) => fakeClubNotAdmin,
          child: const GroupSettings(),
        ),
      ],
    ));

    int selectedCount = 0;
    find
        .byType(JoinTokenTile)
        .evaluate()
        .map((e) => e.widget)
        .whereType<JoinTokenTile>()
        .forEach((element) {
      selectedCount++;
    });

    expect(selectedCount, 1);
  });
}
