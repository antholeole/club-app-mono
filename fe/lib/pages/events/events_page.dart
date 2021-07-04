import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsPage extends StatefulWidget {
  final Group? _group;

  const EventsPage({Group? group}) : _group = group;

  @override
  _EventsPageState createState() => _EventsPageState();

  static MainScaffoldParts scaffoldWidgets(BuildContext context) {
    return MainScaffoldParts(
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

class _EventsPageState extends State<EventsPage> {
  late void Function() updateScaffold;

  @override
  void initState() {
    super.initState();
    updateScaffold = () {
      if (context.read<PageCubit>().state.currentPage == 1) {
        context
            .read<ScaffoldCubit>()
            .updateMainParts(EventsPage.scaffoldWidgets(context));
      }
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //for the first render
    updateScaffold();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PageCubit, PageState>(
      listener: (context, state) => updateScaffold(),
      child: Container(
        color: Colors.blue,
      ),
    );
  }
}
