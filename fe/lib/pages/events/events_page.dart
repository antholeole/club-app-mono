import 'package:fe/data/models/group.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  final Group _group;

  const EventsPage({required Group group}) : _group = group;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }

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
