import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/users.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'package:fe/gql/remove_role_from_user.req.gql.dart';
import 'package:fe/gql/add_roles_to_users.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show Guser_to_role_insert_input;

import '../../../../../../../../../service_locator.dart';
import 'addable_roles_dropdown.dart';

class RoleList extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();
  final _handler = getIt<Handler>();

  static const EXPIRE_AT_DURATION = Duration(seconds: 5);

  RoleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRoles = context.watch<UserRoles>().hasRoles;
    final addableRoles = context.watch<UserRoles>().addableRoles;

    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      ' roles'.toUpperCase() +
                          (userRoles.isEmpty ? ' (none):' : ':'),
                      style: TextStyle(
                          fontFamily: 'IBM Plex Mono',
                          color: Colors.grey.shade700,
                          fontSize: 12.0),
                    ),
                  ),
                  if (addableRoles != null)
                    AddableRoleDropdown(
                      addRoles: (roles) => _addRoles(roles.toList(), context),
                    )
                ],
              ),
              children: context
                  .watch<UserRoles>()
                  .hasRoles
                  .map((role) => _buildRoleTile(role, addableRoles, context))
                  .toList(),
            )));
  }

  Widget _buildRoleTile(
      Role role, List<Role>? addableRoles, BuildContext context) {
    final tile = ListTile(
      title: Text(
        role.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );

    Add / remove roles from group

    if (addableRoles != null) {
      return Dismissible(
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.remove, color: Colors.white),
        ),
        confirmDismiss: (_) {
          final Completer<bool> completer = Completer();

          context.read<ToasterCubit>().add(Toast(
              expireAt: RoleList.EXPIRE_AT_DURATION,
              onDismiss: () {
                if (!completer.isCompleted) completer.complete(false);
              },
              message:
                  'Are you sure you\'d like to remove ${context.read<UserRoles>().user.name} from ${role.name}?',
              action: ToastAction(
                  actionText: 'Remove',
                  action: () => _removeRole(role, context)),
              type: ToastType.Warning));

          Timer(RoleList.EXPIRE_AT_DURATION, () {
            if (!completer.isCompleted) completer.complete(false);
          });

          return completer.future;
        },
        key: Key(role.id.uuid),
        child: tile,
      );
    }

    return tile;
  }

  Future<void> _addRoles(List<Role> roles, BuildContext context) async {
    if (roles.isEmpty) {
      return;
    }

    final user = context.read<UserRoles>().user;

    try {
      await _gqlClient
          .request(GAddRolesToUsersReq(((q) => q
            ..vars.roles =
                ListBuilder(roles.map((e) => Guser_to_role_insert_input((b) => b
                  ..user_id = user.id
                  ..role_id = e.id))))))
          .first;

      context.read<ToasterCubit>().add(Toast(
          message: 'Successfully added roles to ${user.name}',
          type: ToastType.Success));

      context.read<UserRoles>().addRoles(roles);
    } on Failure catch (f) {
      _handler.handleFailure(f, context,
          withPrefix: 'Failed to add roles to ${user.name}');
    }
  }

  Future<void> _removeRole(Role role, BuildContext context) async {
    final user = context.read<UserRoles>().user;

    try {
      await _gqlClient
          .request(GRemoveRoleFromUserReq((q) => q
            ..vars.roleId = role.id
            ..vars.userId = user.id))
          .first;

      context.read<ToasterCubit>().add(Toast(
          message: 'Successfully removed role ${role.name} from ${user.name}',
          type: ToastType.Success));

      context.read<UserRoles>().removeRole(role);
    } on Failure catch (f) {
      _handler.handleFailure(f, context,
          withPrefix: 'Failed to remove role ${role.name} from ${user.name}');
    }
  }
}
