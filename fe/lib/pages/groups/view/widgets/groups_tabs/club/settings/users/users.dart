import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/roles_list/role_list.dart';
import 'package:fe/stdlib/shared_widgets/user_tile.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/gql/query_roles_in_group.data.gql.dart';
import 'package:fe/gql/query_roles_in_group.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class UserRoles extends ChangeNotifier {
  final List<Role> _hasRoles;
  final List<Role>? _addableRoles;
  final User user;

  List<Role> get hasRoles => List.from(_hasRoles);
  List<Role>? get addableRoles =>
      _addableRoles == null ? null : List.from(_addableRoles!);

  UserRoles(
      {required List<Role> hasRoles,
      required this.user,
      List<Role>? addableRoles})
      : _hasRoles = hasRoles,
        _addableRoles = addableRoles;

  void addRoles(Iterable<Role> roles) {
    assert(_addableRoles != null);

    _hasRoles.addAll(roles);
    roles.forEach(_addableRoles!.remove);

    notifyListeners();
  }

  void removeRole(Role role) {
    _hasRoles.remove(role);

    if (_addableRoles != null) {
      _addableRoles!.add(role);
    }

    notifyListeners();
  }
}

class Users extends StatelessWidget {
  @visibleForTesting
  static const String ERROR_LOADING_USERS = 'Error loading members';

  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return Column(
      children: [
        const TileHeader(text: 'Members'),
        GqlOperation(
            operationRequest: GQueryUsersInGroupReq(
              (b) => b
                ..fetchPolicy = FetchPolicy.CacheAndNetwork
                ..vars.groupId = group.id,
            ),
            errorText: ERROR_LOADING_USERS,
            onResponse: (GQueryUsersInGroupData userData) {
              if (group.admin) {
                return GqlOperation(
                  operationRequest:
                      GQueryRolesInGroupReq((r) => r..vars.groupId = group.id),
                  onResponse: (GQueryRolesInGroupData roles) {
                    return _buildUsers(
                        userData,
                        roles.roles
                            .map((role) => Role(id: role.id, name: role.name)));
                  },
                );
              } else {
                return _buildUsers(userData, null);
              }
            }),
      ],
    );
  }

  Widget _buildUsers(
      GQueryUsersInGroupData userData, Iterable<Role>? allRoles) {
    return Column(
        children: userData.user_to_group.map(
      (userData) {
        final userRoles = userData.user!.user_to_roles
            .map((role) => Role(id: role.role.id, name: role.role.name))
            .toList();

        List<Role>? addableRole;
        if (allRoles != null) {
          addableRole = [];
          final userRolesSet = userRoles.toSet();

          for (final existingRole in allRoles) {
            if (!userRolesSet.contains(existingRole)) {
              addableRole.add(existingRole);
            }
          }
        }

        final user = User(
          id: userData.user!.id,
          name: userData.user!.name,
          profilePictureUrl: userData.user!.profile_picture,
        );

        return UserTile(
          user: user,
          bottomWidget: ChangeNotifierProvider(
            create: (_) => UserRoles(
                hasRoles: userRoles, addableRoles: addableRole, user: user),
            child: RoleList(),
          ),
        );
      },
    ).toList());
  }
}
