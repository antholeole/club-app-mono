import 'package:fe/gql/fragments/group.data.gql.dart';
import 'package:fe/gql/remote/query_self_group_preview.data.gql.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/groups/widgets/group_tab.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:flutter/material.dart';

import '../../../../../../stdlib/errors/failure.dart';
import 'groups_service.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final GroupsService _groupsService = getIt<GroupsService>();
  late Future<GQuerySelfGroupsPreviewData> groups;

  @override
  void initState() {
    groups = _groupsService.fetchGroups(remote: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder<GQuerySelfGroupsPreviewData>(
        future: groups,
        builder: (fbContext, snapshot) {
          if (snapshot.hasError && snapshot.error is Failure) {
            handleFailure(snapshot.error as Failure, fbContext);
          }

          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return _buildGroups(snapshot.data!, context);
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

  Widget _buildGroups(
      GQuerySelfGroupsPreviewData groups, BuildContext context) {
    final List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Your Clubs',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(
        child: ListView(
          shrinkWrap: true,
          children: groups.user_to_group
              .map(
                (v) => GroupTab(
                  group: GGroupData().rebuild((b) => b
                    ..group_name = v.group.group_name
                    ..id = v.group.id),
                  didUpdateGroups: _didUpdateGroups,
                ),
              )
              .toList(),
        ),
      )
    ];

    if (groups.user_to_group.isEmpty) {
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

  void _didUpdateGroups() {
    setState(() {
      groups = _groupsService.fetchGroups(remote: false);
    });
  }
}
