import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class GroupJoiner {
  final VoidCallback showPrompt;

  const GroupJoiner({required this.showPrompt});
}

// ignore: must_be_immutable
class GroupJoinDisplay extends StatelessWidget {
  final Widget _child;

  const GroupJoinDisplay({Key? key, required Widget child})
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
              title: const Text('Enter a club\'s join code'),
              content: PlatformTextField(
                controller: textEditingController,
                hintText: 'Join code...',
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  cupertino: (_, __) =>
                      CupertinoDialogActionData(isDestructiveAction: true),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                PlatformDialogAction(
                  onPressed: () => print('hi'),

                  /*_gqlClient.mutateFromUi<GAddRoleToGroupData,
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
                          */
                  child: const Text('Join'),
                ),
              ],
            ));
  }
}
