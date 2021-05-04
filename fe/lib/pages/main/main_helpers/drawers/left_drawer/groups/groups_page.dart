import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/service_locator.dart';
import 'package:flutter/material.dart';

import 'group_tab.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final _groupRepository = getIt<GroupRepository>();
  List<Group> cachedGroups = <Group>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder<List<Group>>(
        future: _fetchGroups(),
        initialData: [],
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return _buildGroups(snapshot.data ?? []);
            case ConnectionState.none:
              return _buildError();
          }
        },
      ),
    );
  }

  Future<List<Group>> _fetchGroups() async {
    final groups = await _groupRepository.findAll();
    setState(() {
      cachedGroups = groups;
    });

    return groups;
  }

  Widget _buildError() {
    return Text("sorry, couldn't load your groups.");
  }

  Widget _buildGroups(List<Group> groups) {
    final List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Your Clubs',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      ListView(
        shrinkWrap: true,
        children: groups.map((v) => GroupTab(group: v)).toList(),
      )
    ];

    if (groups.isEmpty) {
      widgets.add(Expanded(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'You have no clubs. Go ahead and join some!',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ))));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }
}
