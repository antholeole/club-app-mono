import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/features/log_out/log_out.dart';
import 'package:fe/pages/profile/features/name_change/cubit/name_change_cubit.dart';
import 'package:fe/pages/profile/features/debug_settings/debug_settings.dart';
import 'package:fe/pages/profile/features/name_change/name_change.dart';
import 'package:fe/pages/profile/features/profile_picture/cubit/profile_picture_change_cubit.dart';
import 'package:fe/pages/profile/features/profile_picture/profile_picture.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config.dart';
import '../../service_locator.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NameChangeCubit(),
        ),
        BlocProvider(
          create: (context) => ProfilePictureChangeCubit(
              selfId: context.read<UserCubit>().user.id),
        ),
      ],
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  final _config = getIt<Config>();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().user;

    return Column(children: [
      SelfProfilePicture(),
      Text(
        user.name,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
      ButtonGroup(name: 'Profile', buttons: [
        NameChange(),
        const LogOut(),
      ]),
      if (!_config.prod) DebugSettings()
    ]);
  }
}
