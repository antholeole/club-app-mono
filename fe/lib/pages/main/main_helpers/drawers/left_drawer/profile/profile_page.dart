import 'package:fe/config.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile/profile_page_service.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/DEBUG_print.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfilePageService _profilePageService = getIt<ProfilePageService>();
  final TokenManager _tokenManager = getIt<TokenManager>();
  bool _changingName = false;
  bool _loggingOut = false;
  final LocalUser _localUser = getIt<LocalUser>();
  final Config _config = getIt<Config>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown.shade800,
          minRadius: 50,
          maxRadius: 50,
          child: Text('AO'),
        ),
        Text(
          _localUser.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonGroup(name: 'Profile', buttons: [
              LoadableTileButton(
                  onClick: _changeName,
                  text: 'Change name',
                  loading: _changingName),
            ]),
            ButtonGroup(buttons: [
              LoadableTileButton(
                  onClick: () {
                    setState(() {
                      _loggingOut = false;
                    });
                    context.read<MainPageActionsCubit>().logout();
                  },
                  color: Colors.red,
                  text: 'Log Out',
                  loading: _loggingOut),
            ]),
            _config.debug
                ? ButtonGroup(name: 'Debug', buttons: [
                    LoadableTileButton(
                        onClick: () => _tokenManager.read().then((tokens) =>
                            printWrapped(
                                tokens?.accessToken ?? 'No Access Tokens')),
                        text: 'Print Access Token',
                        loading: false),
                  ])
                : Container(),
          ],
        )
      ],
    );
  }

  void _changeName() {
    TextEditingController textEditingController = TextEditingController();

    void _tryUpdateName() async {
      setState(() {
        _changingName = true;
      });

      try {
        await _profilePageService.changeName(textEditingController.text);
        Toaster.of(context).successToast('Name changed successfully!');
      } on Failure catch (f) {
        Toaster.of(context).errorToast("Couldn't change name: ${f.message}");
      } finally {
        Navigator.of(context).pop();

        //side effect: If name trigger succeeded, will reload localUser
        //to display the new name
        setState(() {
          _changingName = false;
        });
      }
    }

    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Enter Your New Name'),
        content: PlatformTextField(
          controller: textEditingController,
          hintText: 'New name...',
        ),
        actions: <Widget>[
          PlatformDialogAction(
            cupertino: (_, __) =>
                CupertinoDialogActionData(isDestructiveAction: true),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'),
          ),
          PlatformDialogAction(
            onPressed: _tryUpdateName,
            child: Text('update'),
          ),
        ],
      ),
    );
  }
}
