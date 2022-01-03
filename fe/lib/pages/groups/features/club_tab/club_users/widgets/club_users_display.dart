import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/features/club_tab/club_users/widgets/role_list.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/shared_widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';

class ClubUsersDisplay extends StatelessWidget {
  final GQueryUsersInGroupData _data;
  final Iterable<Role>? _allRoles;

  const ClubUsersDisplay(
      {Key? key,
      required GQueryUsersInGroupData data,
      Iterable<Role>? allRoles})
      : _data = data,
        _allRoles = allRoles,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _data.user_to_group.map(
      (userData) {
        final userRoles = userData.user!.user_to_roles
            .map((role) => Role(id: role.role.id, name: role.role.name))
            .toList();

        List<Role>? addableRole;
        if (_allRoles != null) {
          addableRole = [];
          final userRolesSet = userRoles.toSet();

          for (final existingRole in _allRoles!) {
            if (!userRolesSet.contains(existingRole)) {
              addableRole.add(existingRole);
            }
          }
        }

        final user = User(
          id: userData.user!.id,
          name: userData.user!.name,
        );

        return UserTile(
          user: user,
          showDmButton: context.read<UserCubit>().user.id != user.id,
          subtitle: ClubUserRoleList(
            user: user,
            hasRoles: userRoles,
            addableRoles: addableRole,
          ),
        );
      },
    ).toList());
  }
}
