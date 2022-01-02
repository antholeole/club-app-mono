import 'package:built_collection/built_collection.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:fe/gql/join_roles_with_join_codes.data.gql.dart';
import 'package:fe/gql/join_roles_with_join_codes.req.gql.dart';
import 'package:fe/gql/join_roles_with_join_codes.var.gql.dart';

import '../../service_locator.dart';

class GroupJoiner {
  final AsyncCallback showPrompt;

  const GroupJoiner({required this.showPrompt});
}

class GroupJoinDisplay extends StatelessWidget {
  static const JOIN_GROUP_PROMPT_COPY = 'Enter a club\'s join code';
  static const CANCEL_JOIN_GROUP_BUTTON_COPY = 'Cancel';
  static const JOIN_GROUP_BUTTON_COPY = 'Join';

  final Widget _child;
  final _gqlClient = getIt<AuthGqlClient>();

  GroupJoinDisplay({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GroupJoiner>(
      create: (_) => GroupJoiner(showPrompt: () => showPrompt(context)),
      child: _child,
    );
  }

  Future<void> showPrompt(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();

    await showPlatformDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) => PlatformAlertDialog(
              title: const Text(JOIN_GROUP_PROMPT_COPY),
              content: PlatformTextField(
                controller: textEditingController,
                hintText: 'Join code...',
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  cupertino: (_, __) =>
                      CupertinoDialogActionData(isDestructiveAction: true),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(CANCEL_JOIN_GROUP_BUTTON_COPY),
                ),
                PlatformDialogAction(
                  onPressed: () {
                    _gqlClient
                        .mutateFromUi<GJoinRolesWithJoinCodesData,
                                GJoinRolesWithJoinCodesVars>(
                            GJoinRolesWithJoinCodesReq((q) => q
                              ..vars.join_codes = ListBuilder<String>(
                                  textEditingController.text.split('+'))),
                            context,
                            errorMessage: 'failed to join roles',
                            successMessage: 'joined!')
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: const Text(JOIN_GROUP_BUTTON_COPY),
                ),
              ],
            ));
  }
}
