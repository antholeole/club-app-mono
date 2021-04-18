import 'package:fe/data_classes/local_user.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile_page/profile_page_service.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfilePage extends StatefulWidget {
  final LocalUser _localUser = getIt<LocalUser>();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfilePageService _profilePageService = getIt<ProfilePageService>();
  bool _changingName = false;

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
          widget._localUser.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonGroup(name: 'Profile', buttons: [
              ButtonData(
                  onClick: _changeName,
                  text: 'Change name',
                  loading: _changingName),
            ]),
            ButtonGroup(buttons: [
              ButtonData(
                  onClick: () => context.read<MainPageActionsCubit>().logout(),
                  color: Colors.red,
                  text: 'Log Out'),
            ]),
          ],
        )
      ],
    );
  }

  void _changeName() {
    TextEditingController textEditingController = TextEditingController();

    void _tryUpdateName() {
      setState(() {
        _changingName = true;
      });
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
            child: Text('hi2'),
          ),
        ],
      ),
    );
  }
}
