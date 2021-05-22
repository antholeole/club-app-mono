import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/gql/query_self_group_preview.var.gql.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/groups/widgets/group_tab.dart';
import 'package:fe/service_locator.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../../stdlib/local_user.dart';
import '../../../../../../stdlib/theme/loader.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final Client _client = getIt<Client>();
  final LocalUser _localUser = getIt<LocalUser>();

  late GQuerySelfGroupsPreviewReq _groupsReq;

  @override
  void initState() {
    _groupsReq = GQuerySelfGroupsPreviewReq((b) => b
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.self_id = _localUser.uuid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Operation(
          client: _client,
          operationRequest: _groupsReq,
          builder: (context,
              OperationResponse<GQuerySelfGroupsPreviewData,
                      GQuerySelfGroupsPreviewVars>?
                  response,
              error) {
            if (response!.loading) {
              return Loader();
            }

            return _buildGroups(response.data!.user_to_group.map((utg) => Group(
                admin: utg.admin,
                id: utg.group.id,
                name: utg.group.group_name)));
          }),
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
        ..vars.self_id = _localUser.uuid);
    });
  }
}
