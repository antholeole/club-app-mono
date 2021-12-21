import 'package:built_collection/built_collection.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/role_manager.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/remove_role_from_user.req.gql.dart';
import 'package:fe/gql/add_roles_to_users.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show Guser_to_role_insert_input;

import '../../../../../../../../service_locator.dart';

class RoleList extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();

  final List<Role>? _addableRoles;
  final List<Role> _hasRoles;
  final User _user;

  RoleList(
      {Key? key,
      List<Role>? addableRoles,
      required List<Role> hasRoles,
      required User user})
      : _addableRoles = addableRoles,
        _user = user,
        _hasRoles = hasRoles,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
            child: RoleManager(
                header: Text(
                  ' roles:'.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'IBM Plex Mono',
                      color: Colors.grey.shade700,
                      fontSize: 12.0),
                ),
                initalRoles: _hasRoles,
                roleManagerData: _addableRoles == null
                    ? null
                    : RoleManagerData(
                        addRoles: (roles) => _gqlClient
                            .request(GAddRolesToUsersReq(((q) => q
                              ..vars.roles = ListBuilder(roles.map(
                                  (e) => Guser_to_role_insert_input((b) => b
                                    ..user_id = _user.id
                                    ..role_id = e.id))))))
                            .first,
                        failedToAddRolesText: () =>
                            'Failed to add roles to ${_user.name}',
                        failedToRemoveRoleText: (role) =>
                            'Failed to remove role ${role.name} from ${_user.name}',
                        initalAddableRoles: _addableRoles!,
                        removeRole: (role) => _gqlClient
                            .request(GRemoveRoleFromUserReq((q) => q
                              ..vars.roleId = role.id
                              ..vars.userId = _user.id))
                            .first,
                        removeRolePromptText: (role) =>
                            'Are you sure you\'d like to remove ${_user.name} from ${role.name}?',
                        successfullyAddedRolesText: (_) =>
                            'Successfully added roles to ${_user.name}',
                        successfullyRemovedRoleText: (role) =>
                            'Successfully removed role ${role.name} from ${_user.name}'))));
  }
}
