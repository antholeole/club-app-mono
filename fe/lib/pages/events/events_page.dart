import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_cubit.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<EventsPage> {
  @override
  void didChangeDependencies() {
    if (AutoRouter.of(context).innerRouterOf(Main.name)!.topRoute.name ==
        EventsRoute.name) {
      context
          .read<MainScaffoldCubit>()
          .updateMainScaffold(_mainScaffoldParts());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }

  MainScaffoldUpdate _mainScaffoldParts() {
    return MainScaffoldUpdate(
        actionButtons: [
          ActionButton(
              icon: Icons.baby_changing_station,
              onClick: () {
                print('hi 4!');
              }),
          ActionButton(
              icon: Icons.baby_changing_station_outlined,
              onClick: () {
                print('hi 3!');
              }),
        ],
        endDrawer: Container(
          color: Colors.pink,
        ),
        titleBarWidget: Text('not donkey'));
  }
}
