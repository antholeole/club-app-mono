import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/pages/main/main_helpers/scaffold/drawers/left_drawer/groups/widgets/group_tab.dart';
import 'package:fe/pages/main/providers/user_provider.dart';

import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';

import 'package:flutter/material.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late GQuerySelfGroupsPreviewReq _groupsReq;

  @override
  void didChangeDependencies() {
    _groupsReq = GQuerySelfGroupsPreviewReq((b) => b
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.self_id = UserProvider.of(context)!.user.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: _groupsReq != null
          ? GqlOperation(
              operationRequest: _groupsReq,
              onResponse: (GQuerySelfGroupsPreviewData data) => _buildGroups(
                data.user_to_group.map(
                  (utg) => Group(
                      admin: utg.admin,
                      id: utg.group.id,
                      name: utg.group.group_name),
                ),
              ),
              error: Center(
                child: Text('sorry, there was an error loading groups.'),
              ),
            )
          : Center(
              child: Loader(),
            ),
    );
  }

  Widget _buildGroups(Iterable<Group> groups) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Your Clubs',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      groups.isNotEmpty
          ? Expanded(
              child: ListView(
                  shrinkWrap: true,
                  children: groups
                      .map(
                        (v) => GroupTab(
                          group: v,
                          didUpdateGroups: _didUpdateGroups,
                        ),
                      )
                      .toList()),
            )
          : Expanded(
              child: Center(
                  child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You have no clubs. Go ahead and join some!',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            )))
    ]);
  }

  void _didUpdateGroups() {
    setState(() {
      _groupsReq = GQuerySelfGroupsPreviewReq((b) => b
        ..fetchPolicy = FetchPolicy.CacheOnly
        ..vars.self_id = UserProvider.of(context)!.user.id);
    });
  }
}
