import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/pages/groups/features/club_tab/club_users/widgets/club_users_display.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/gql/query_roles_in_group.data.gql.dart';
import 'package:fe/gql/query_roles_in_group.req.gql.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ClubUsers extends StatelessWidget {
  @visibleForTesting
  static const String ERROR_LOADING_USERS = 'Error loading members';

  const ClubUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return ExpansionTile(
      title: const Text('Members'),
      children: [
        GqlOperation(
            operationRequest: GQueryUsersInGroupReq(
              (b) => b..vars.groupId = group.id,
            ),
            errorText: ERROR_LOADING_USERS,
            onResponse: (GQueryUsersInGroupData userData) {
              if (group.admin) {
                return GqlOperation(
                  operationRequest:
                      GQueryRolesInGroupReq((r) => r..vars.groupId = group.id),
                  onResponse: (GQueryRolesInGroupData roles) {
                    return ClubUsersDisplay(
                        data: userData,
                        allRoles: roles.roles
                            .map((role) => Role(id: role.id, name: role.name)));
                  },
                );
              } else {
                return ClubUsersDisplay(data: userData);
              }
            })
      ],
    );
  }
}
