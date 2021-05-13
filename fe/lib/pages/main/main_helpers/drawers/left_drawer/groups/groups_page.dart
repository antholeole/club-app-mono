import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/database/db_manager.dart';
import 'package:flutter/material.dart';

import 'group_tab.dart';
import 'groups_service.dart';

class GroupsPage extends StatelessWidget {
  final GroupsService _groupsService = getIt<GroupsService>();

  GroupsPage() {
    _groupsService.cacheIfNecessary();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder<List<Group>>(
        future: _groupsService.fetchGroups(),
        initialData: _groupsService.cachedGroups,
        builder: (fbContext, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return _buildGroups(snapshot.data ?? [], context);
            case ConnectionState.none:
              return _buildError();
          }
        },
      ),
    );
  }

  Widget _buildError() {
    return Text("sorry, couldn't load your groups.");
  }

  Widget _buildGroups(List<Group> groups, BuildContext context) {
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
