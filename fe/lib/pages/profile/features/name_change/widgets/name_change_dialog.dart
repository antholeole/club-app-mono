import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/features/name_change/cubit/name_change_cubit.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/src/provider.dart';

class NameChangeDialog extends StatelessWidget {
  static const UPDATE_NAME_BUTTON_COPY = 'Update';
  static const CANCEL_NAME_CHANGE_COPY = 'cancel';

  final TextEditingController _controller = TextEditingController();

  NameChangeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: const Text('Enter Your New Name'),
      content: PlatformTextField(
        controller: _controller,
        hintText: 'New name...',
      ),
      actions: <Widget>[
        PlatformDialogAction(
          cupertino: (_, __) =>
              CupertinoDialogActionData(isDestructiveAction: true),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(CANCEL_NAME_CHANGE_COPY),
        ),
        PlatformDialogAction(
          onPressed: () {
            context.read<NameChangeCubit>().changeName(_controller.text, () {
              Navigator.of(context).pop();
              context.read<ToasterCubit>().add(Toast(
                    message: 'Sucessfully changed name!',
                    type: ToastType.Success,
                  ));
              context.read<UserCubit>().notifyUpdate();
            });
          },
          child: const Text(UPDATE_NAME_BUTTON_COPY),
        ),
      ],
    );
  }
}
