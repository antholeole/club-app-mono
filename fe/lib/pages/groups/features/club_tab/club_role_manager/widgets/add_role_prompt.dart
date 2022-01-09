import 'package:fe/data/models/group.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fe/gql/add_role_to_group.req.gql.dart';
import 'package:fe/gql/add_role_to_group.data.gql.dart';
import 'package:fe/gql/add_role_to_group.var.gql.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:provider/src/provider.dart';

import '../../../../../../service_locator.dart';

class AddRolePrompt extends StatelessWidget {
  static const NEW_ROLE_PROMPT_COPY = 'Enter the new role\'s name';
  static const ADD_NEW_ROLE_BUTTON_COPY = 'Create';

  AddRolePrompt({Key? key}) : super(key: key);

  final _gqlClient = getIt<AuthGqlClient>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: const Text(NEW_ROLE_PROMPT_COPY),
      content: PlatformTextField(
        controller: _controller,
        hintText: 'New name...',
      ),
      actions: <Widget>[
        PlatformDialogAction(
          material: (context, platform) => MaterialDialogActionData(),
          cupertino: (_, __) =>
              CupertinoDialogActionData(isDestructiveAction: true),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        PlatformDialogAction(
          onPressed: () => _gqlClient
              .mutateFromUi<GAddRoleToGroupData, GAddRoleToGroupVars>(
                  GAddRoleToGroupReq((q) => q
                    ..vars.groupId = context.read<Club>().id
                    ..vars.roleName = _controller.text),
                  context, onComplete: (roleData) {
            context
                .read<ReRequester<GQuerySelfGroupsData, GQuerySelfGroupsVars>>()
                .reRequest();

            Navigator.of(context).pop();
          },
                  errorMessage: 'failed to add role ${_controller.text}',
                  successMessage: 'added role ${_controller.text}.'),
          child: const Text(ADD_NEW_ROLE_BUTTON_COPY),
        ),
      ],
    );
  }
}
