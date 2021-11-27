import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/query_users_in_thread.data.gql.dart';
import 'package:fe/gql/query_users_in_thread.var.gql.dart';
import 'package:fe/gql/query_users_in_thread.req.gql.dart';
import 'package:fe/gql/query_users_in_dm.data.gql.dart';
import 'package:fe/gql/query_users_in_dm.var.gql.dart';
import 'package:fe/gql/query_users_in_dm.req.gql.dart';

class ThreadMembersDrawer extends StatelessWidget {
  final Thread _thread;
  final Group _group;

  @visibleForTesting
  static const NO_USERS_COPY = 'There are no users in this thread.';

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.85;
  }

  const ThreadMembersDrawer(
      {Key? key, required Thread thread, required Group group})
      : _thread = thread,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inner;

    if (_group is Club) {
      inner = _groupInner();
    } else if (_group is Dm) {
      inner = _dmInner();
    } else {
      throw Exception('unhandled type for group ${_group.runtimeType}');
    }

    return Container(
      width: ThreadMembersDrawer.getWidth(context),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              '${_thread.name} Members',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 30,
            ),
            Expanded(child: inner)
          ],
        ),
      ),
    );
  }

  Widget _dmInner() {
    return GqlOperation<GQueryUsersInDmData, GQueryUsersInDmVars>(
        operationRequest:
            GQueryUsersInDmReq((req) => req..vars.dmId = _thread.id),
        onResponse: (data) => _buildUsersWidget(
            data.user_to_dm.map((user) => User(
                id: user.user.id,
                name: user.user.name,
                profilePictureUrl: user.user.profile_picture)),
            []));
  }

  Widget _groupInner() {
    final List<ActionButton> actions = [];

    if ((_group as Club).admin) {
      actions.add(ActionButton(icon: Icons.person_remove, onClick: () {}));
    }

    return GqlOperation<GQueryUsersInThreadData, GQueryUsersInThreadVars>(
        operationRequest:
            GQueryUsersInThreadReq((req) => req..vars.threadId = _thread.id),
        onResponse: (data) => _buildUsersWidget(
            data.user_to_thread.map((user) => User(
                name: user.user!.name,
                id: user.user!.id,
                profilePictureUrl: user.user!.profile_picture)),
            actions));
  }

  Widget _buildUsersWidget(Iterable<User> users, List<ActionButton> actions) {
    if (users.isEmpty) {
      return const Center(
        child: Text(NO_USERS_COPY),
      );
    }

    return ListView(
      children: users
          .map((user) => UserTile(
                user: user,
                actions: actions,
              ))
          .toList(),
    );
  }
}
