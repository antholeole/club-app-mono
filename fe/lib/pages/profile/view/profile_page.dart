import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/profile/cubit/log_out_cubit.dart';
import 'package:fe/pages/profile/cubit/name_change_cubit.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flow_builder/flow_builder.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogOutCubit(),
        ),
        BlocProvider(
          create: (context) => NameChangeCubit(),
        ),
      ],
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.of(context);

    return Column(
      children: [
        UserAvatar(
          name: userProvider.user.name,
          radius: 50,
        ),
        Text(
          userProvider.user.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<NameChangeCubit, NameChangeState>(
                builder: (context, state) => state.join(
                      (_) => _buildChangeNameButton(false, context),
                      (_) => _buildChangeNameButton(true, context),
                      (_) => _buildChangeNameButton(true, context),
                    ),
                listener: (context, state) => state.join(
                      (_) => null,
                      (_) => null,
                      (errorState) => handleFailure(errorState.failure, context,
                          withPrefix: "Couldn't change name"),
                    )),
            BlocConsumer<LogOutCubit, LogOutState>(
                listener: (context, state) => state.join(
                    (_) => null,
                    (_) => null,
                    (_) => context
                        .flow<AppState>()
                        .update((_) => AppState.needLogIn()),
                    (errorState) => handleFailure(errorState.failure, context)),
                builder: (context, state) => state.join(
                    (_) => _buildLogOutButton(false, context),
                    (_) => _buildLogOutButton(true, context),
                    (loggedOut) => const Text('logged out!'),
                    (_) => _buildLogOutButton(false, context))),
          ],
        )
      ],
    );
  }

  Widget _buildChangeNameButton(bool loading, BuildContext context) {
    return ButtonGroup(name: 'Profile', buttons: [
      LoadableTileButton(
          onClick: () => _showChangeNameDialog(context),
          text: 'Change name',
          loading: loading),
    ]);
  }

  Widget _buildLogOutButton(bool loading, BuildContext context) {
    return ButtonGroup(buttons: [
      LoadableTileButton(
          onClick: context.read<LogOutCubit>().logOut,
          color: Colors.red,
          text: 'Log Out',
          loading: loading),
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
            child: const Text('cancel'),
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
                UserProvider.of(context).notifyUpdate();
              });
            },
            child: const Text('update'),
          ),
        ],
      ),
    );
  }
}
