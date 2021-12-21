import 'package:built_collection/built_collection.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/gql/query_all_roles_relative_to_thread.req.gql.dart';
import 'package:fe/gql/remove_role_from_thread.req.gql.dart';
import 'package:fe/gql/query_all_roles_relative_to_thread.var.gql.dart';
import 'package:fe/gql/query_all_roles_relative_to_thread.data.gql.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/role_manager.dart';
import 'package:fe/gql/add_roles_to_thread.req.gql.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/schema.schema.gql.dart' show Grole_to_threads_insert_input;

import '../../../../../../service_locator.dart';

class ThreadRoles extends StatelessWidget {
  final _authGqlClient = getIt<AuthGqlClient>();

  final Club _club;

  ThreadRoles({Key? key, required Club club})
      : _club = club,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final thread = context.read<Thread>();

    return GqlOperation<GQueryAllRolesRelativeToThreadData,
            GQueryAllRolesRelativeToThreadVars>(
        operationRequest: GQueryAllRolesRelativeToThreadReq((q) => q
          ..vars.threadId = thread.id
          ..vars.groupId = _club.id),
        onResponse: (req) {
          final hasRoles = req.roles
              .where((roleData) => roleData.role_to_threads.isNotEmpty)
              .map((roleData) => Role(id: roleData.id, name: roleData.name))
              .toList();
          List<Role>? addableRoles;

          if (_club.admin) {
            addableRoles = [];

            for (final role in req.roles) {
              if (role.role_to_threads.isEmpty) {
                addableRoles.add(Role(id: role.id, name: role.name));
              }
            }
          }

          return RoleManager(
            header: const Text('Roles'),
            initalRoles: hasRoles,
            roleManagerData: _club.admin
                ? RoleManagerData(
                    initalAddableRoles: addableRoles!,
                    addRoles: (roles) => _authGqlClient
                        .request(GAddRolesToThreadsReq((q) => q
                          ..vars.roles = ListBuilder(roles
                              .map((e) => Grole_to_threads_insert_input((a) => a
                                ..role_id = e.id
                                ..thread_id = thread.id)))))
                        .first,
                    removeRole: (role) => _authGqlClient
                        .request(GRemoveRoleFromThreadReq((q) => q
                          ..vars.roleId = role.id
                          ..vars.threadId = thread.id))
                        .first,
                    successfullyRemovedRoleText: (role) =>
                        'removed role ${role.name} from ${thread.name}.',
                    removeRolePromptText: (role) =>
                        'remove role ${role.name} from ${thread.name}?',
                    successfullyAddedRolesText: (_) =>
                        'successfully added roles to ${thread.name}',
                    failedToAddRolesText: () =>
                        'failed to add roles to ${thread.name}',
                    failedToRemoveRoleText: (role) =>
                        'failed to remove role ${role.name} from ${thread.name}')
                : null,
          );
        });
  }
}
