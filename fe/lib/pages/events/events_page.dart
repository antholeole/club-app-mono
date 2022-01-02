import 'package:fe/data/models/group.dart';
import 'package:fe/pages/scaffold/main_scaffold.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  // ignore: unused_field
  final Club? _group;

  const EventsPage({Club? group}) : _group = group;

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(child: Text('events'));
  }
}
