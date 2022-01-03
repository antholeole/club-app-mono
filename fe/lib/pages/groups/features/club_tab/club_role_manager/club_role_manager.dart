import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/features/club_tab/club_role_manager/widgets/add_role_prompt.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/shared_widgets/prompt_injector.dart';
import 'package:fe/stdlib/shared_widgets/toasting_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.req.gql.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.data.gql.dart';
import 'package:fe/gql/query_roles_in_group_with_join_code.var.gql.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/remove_role_from_group.req.gql.dart';

import '../../../../../service_locator.dart';

class ClubRoleManager extends StatelessWidget {
  ClubRoleManager({Key? key}) : super(key: key);

  final AuthGqlClient _gqlClient = getIt<AuthGqlClient>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          'Group Roles',
        ),
        GestureDetector(
            onTap: () => showPlatformDialog(
                context: context,
                useRootNavigator: false,
                builder: (_) => PromptInjector(
                    readableContext: context,
                    providers: [
                      Provider<
                              ReRequester<GQuerySelfGroupsData,
                                  GQuerySelfGroupsVars>>.value(
                          value: context.read<
                              ReRequester<GQuerySelfGroupsData,
                                  GQuerySelfGroupsVars>>()),
                      Provider<Club>.value(value: context.read<Club>())
                    ],
                    child: AddRolePrompt())),
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
}

class Prompt {}
