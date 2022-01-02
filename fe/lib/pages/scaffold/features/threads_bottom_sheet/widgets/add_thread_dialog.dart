import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fe/gql/add_thread_to_group.req.gql.dart';
import 'package:fe/gql/add_thread_to_group.var.gql.dart';
import 'package:fe/gql/add_thread_to_group.data.gql.dart';
import 'package:provider/src/provider.dart';

class AddThreadDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final AuthGqlClient _authGqlClient = getIt<AuthGqlClient>();

  AddThreadDialog({Key? key}) : super(key: key);

  static Future<Thread?> show(BuildContext context) {
    return showPlatformDialog(
        context: context, builder: (_) => AddThreadDialog());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: const Text('Enter the new thread\'s name'),
      content: PlatformTextField(
        controller: _controller,
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
          onPressed: () => _authGqlClient.mutateFromUi<GAddThreadToGroupData,
                  GAddThreadToGroupVars>(
              GAddThreadToGroupReq((q) => q
                ..vars.groupId = context.read<Group>().id
                ..vars.threadName = _controller.text),
              context, onComplete: (threadData) {
            Navigator.of(context).pop(Thread(
                name: threadData.insert_threads_one!.name,
                isViewOnly: true,
                id: threadData.insert_threads_one!.id));
          },
              errorMessage: 'failed to add thread ${_controller.text}',
              successMessage:
                  'added thread ${_controller.text} - remember to add roles to the thread!'),
          child: const Text('Create'),
        ),
      ],
    );
  }
}
