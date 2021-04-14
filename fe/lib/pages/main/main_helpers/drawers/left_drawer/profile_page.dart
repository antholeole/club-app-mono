import 'package:fe/data_classes/local_user.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final LocalUser _localUser = getIt<LocalUser>();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown.shade800,
          child: Text('AO'),
          minRadius: 50,
          maxRadius: 50,
        ),
        Text(
          widget._localUser.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        GestureDetector(
            child: Text('click me'),
            onTap: () => context.read<MainPageActionsCubit>().logout())
      ],
    );
  }
}
