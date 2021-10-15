import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/cubit/name_change_cubit.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../service_locator.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NameChangeCubit(),
        ),
      ],
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  static const CHANGE_NAME_COPY = 'Change Name';
  static const UPDATE_NAME_BUTTON_COPY = 'Update';
  static const LOGOUT_COPY = 'Log Out';
  static const CANCEL_NAME_CHANGE_COPY = 'cancel';

  final _handler = getIt<Handler>();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().user;

    return Column(
      children: [
        UserAvatar(
          name: user.name,
          radius: 50,
        ),
        Text(
          user.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<NameChangeCubit, NameChangeState>(
                builder: (context, state) => state.join(
                      (_) => _buildChangeNameButton(false, context),
                      (_) => _buildChangeNameButton(true, context),
                      (_) => _buildChangeNameButton(false, context),
                    ),
                listener: (context, state) => state.join(
                      (_) => null,
                      (_) => null,
                      (errorState) => _handler.handleFailure(
                          errorState.failure, context,
                          withPrefix: "Couldn't change name"),
                    )),
            _buildLogOutButton(context),
          ],
        )
      ],
    );
  }

  Widget _buildChangeNameButton(bool loading, BuildContext context) {
    return ButtonGroup(name: 'Profile', buttons: [
      LoadableTileButton(
          onClick: () => _showChangeNameDialog(context),
          text: ProfileView.CHANGE_NAME_COPY,
          loading: loading),
    ]);
  }

  Widget _buildLogOutButton(BuildContext context) {
    return ButtonGroup(buttons: [
      LoadableTileButton(
          onClick: context.read<MainCubit>().logOut,
          color: Colors.red,
          text: ProfileView.LOGOUT_COPY),
    ]);
  }

  void _showChangeNameDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    showPlatformDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Enter Your New Name'),
        content: PlatformTextField(
          controller: textEditingController,
          hintText: 'New name...',
        ),
        actions: <Widget>[
          PlatformDialogAction(
            cupertino: (_, __) =>
                CupertinoDialogActionData(isDestructiveAction: true),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(ProfileView.CANCEL_NAME_CHANGE_COPY),
          ),
          PlatformDialogAction(
            onPressed: () {
              context
                  .read<NameChangeCubit>()
                  .changeName(textEditingController.text, () {
                Navigator.of(context).pop();
                context.read<ToasterCubit>().add(Toast(
                      message: 'Sucessfully changed name!',
                      type: ToastType.Success,
                    ));
                context.read<UserCubit>().notifyUpdate();
              });
            },
            child: const Text(ProfileView.UPDATE_NAME_BUTTON_COPY),
          ),
        ],
      ),
    );
  }
}
