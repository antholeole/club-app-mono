import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/add_dropdown.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/query_users_in_thread.data.gql.dart';
import 'package:fe/gql/query_users_in_thread.var.gql.dart';
import 'package:fe/gql/query_users_in_thread.req.gql.dart';

class ThreadMembersDrawer extends StatelessWidget {
  final Thread _thread;
  final Group _group;

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
    final List<ActionButton> actions = [];

    if (_group is Club && (_group as Club).admin) {
      actions.add(ActionButton(icon: Icons.person_remove, onClick: () {}));
    }

    final shouldShowAdd =
        (_group is Club && (_group as Club).admin) || _group is Dm;

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
            shouldShowAdd
                ? AddDropdown(
                    thread: _thread,
                    group: _group,
                  )
                : Container(
                    height: 30,
                  ),
            Expanded(
                child: GqlOperation<GQueryUsersInThreadData,
                        GQueryUsersInThreadVars>(
                    operationRequest: GQueryUsersInThreadReq(
                        (req) => req..vars.threadId = _thread.id),
                    onResponse: (data) {
                      if (data.user_to_thread.isEmpty) {
                        return const Center(
                            child: Text('no users in this thread.'));
                      }

                      print(data.user_to_thread.length);
                      return ListView(
                        children: data.user_to_thread
                            .map((user) => UserTile(
                                  user: User(
                                      id: user.user.id,
                                      name: user.user.name,
                                      profilePictureUrl:
                                          user.user.profile_picture),
                                  actions: actions,
                                ))
                            .toList(),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
