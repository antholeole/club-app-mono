import 'package:fe/data/models/club.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/shared_widgets/toasting_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.req.gql.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.data.gql.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.var.gql.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/remove_role_from_group.req.gql.dart';
import 'package:fe/gql/add_role_to_group.req.gql.dart';
import 'package:fe/gql/add_role_to_group.data.gql.dart';
import 'package:fe/gql/add_role_to_group.var.gql.dart';

import '../../../../../../../../service_locator.dart';

class GroupRoleManager extends StatefulWidget {
  static const NEW_ROLE_PROMPT_COPY = 'Enter the new role\'s name';
  static const ADD_NEW_ROLE_BUTTON_COPY = 'Create';

  const GroupRoleManager({Key? key}) : super(key: key);

  @override
  State<GroupRoleManager> createState() => _GroupRoleManagerState();
}

class _GroupRoleManagerState extends State<GroupRoleManager> {
  final AuthGqlClient _gqlClient = getIt<AuthGqlClient>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          'Group Roles',
        ),
        GestureDetector(
            onTap: () => _addRole(context),
            child: const Icon(Icons.add, color: Colors.grey))
      ]),
      children: [
        GqlOperation<GQueryRolesInGroupWithJoinCodeData,
                GQueryRolesInGroupWithJoinCodeVars>(
            operationRequest: GQueryRolesInGroupWithJoinCodeReq(
                (q) => q..vars.groupId = context.read<Club>().id),
            onResponse: (data) => Column(
                  children: data.roles
                      .map((role) => ToastingDismissable(
                            key: ValueKey(role.id.uuid),
                            confirmDismissText:
                                'Are you sure you\'d like to remove role ${role.name}?',
                            onConfirm: () => _gqlClient.mutateFromUi(
                                GRemoveRoleFromGroupReq(
                                    (q) => q..vars.roleId = role.id),
                                context,
                                errorMessage:
                                    'Failed to remove role ${role.name} from ${context.read<Club>().name}',
                                successMessage:
                                    'removed role ${role.name} from ${context.read<Club>().name}'),
                            actionText: 'Remove',
                            child: ListTile(
                              title: Text(
                                role.name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              subtitle: Text(
                                  'join code: ${role.join_token?.token ?? 'NO JOIN CODE'}'),
                            ),
                          ))
                      .toList(),
                ))
      ],
    );
  }

  Future<void> _addRole(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();

    await showPlatformDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) => PlatformAlertDialog(
              title: const Text(GroupRoleManager.NEW_ROLE_PROMPT_COPY),
              content: PlatformTextField(
                controller: textEditingController,
                hintText: 'New name...',
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  cupertino: (_, __) =>
                      CupertinoDialogActionData(isDestructiveAction: true),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                PlatformDialogAction(
                  onPressed: () => _gqlClient.mutateFromUi<GAddRoleToGroupData,
                          GAddRoleToGroupVars>(
                      GAddRoleToGroupReq((q) => q
                        ..vars.groupId = context.read<Club>().id
                        ..vars.roleName = textEditingController.text),
                      context, onComplete: (roleData) {
                    setState(
                        () {}); //requeries, adding the new role to the group

                    Navigator.of(context).pop();
                  },
                      errorMessage:
                          'failed to add role ${textEditingController.text}',
                      successMessage:
                          'added role ${textEditingController.text}.'),
                  child: const Text(GroupRoleManager.ADD_NEW_ROLE_BUTTON_COPY),
                ),
              ],
            ));
  }
}
