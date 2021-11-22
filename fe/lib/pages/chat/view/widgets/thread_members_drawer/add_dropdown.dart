import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/gql/query_members_not_in_thread.req.gql.dart';
import 'package:fe/gql/query_members_not_in_thread.var.gql.dart';
import 'package:fe/gql/query_members_not_in_thread.data.gql.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/thread_members_drawer.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:flutter/material.dart';

enum _DropdownStatus { Loading, Enabled, NoUsers }

class AddDropdown extends StatelessWidget {
  final Thread _thread;
  final Group _group;

  const AddDropdown({Key? key, required Thread thread, required Group group})
      : _thread = thread,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print(_group.id);
    print(_thread.id);
    return GqlOperation<GQueryMembersNotInThreadData,
            GQueryMembersNotInThreadVars>(
        operationRequest: GQueryMembersNotInThreadReq((q) => q
          ..vars.groupId = _group.id
          ..vars.threadId = _thread.id),
        loader: _buildDropdown(context, [], _DropdownStatus.Loading),
        onResponse: (data) {
          if (data.users.isEmpty) {
            return _buildDropdown(context, [], _DropdownStatus.NoUsers);
          }

          final users = data.users.map((utt) => User(
              name: utt.name,
              id: utt.id,
              profilePictureUrl: utt.profile_picture));

          return _buildDropdown(context, users, _DropdownStatus.Enabled);
        });
  }

  Widget _buildDropdown(BuildContext context, Iterable<User> users,
      _DropdownStatus dropdownStatus) {
    String hint;
    switch (dropdownStatus) {
      case _DropdownStatus.Enabled:
        hint = 'Add New Member to ${_thread.name}';
        break;
      case _DropdownStatus.Loading:
        hint = 'Loading Addable Users...';
        break;
      case _DropdownStatus.NoUsers:
        hint = 'All users in group already in ${_thread.name}';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<User>(
        onChanged: dropdownStatus == _DropdownStatus.Enabled ? (_) {} : null,
        value: null,
        disabledHint: dropdownStatus == _DropdownStatus.NoUsers
            ? Text(
                hint,
                textAlign: TextAlign.center,
              )
            : null,
        hint: dropdownStatus == _DropdownStatus.Enabled
            ? Text(
                hint,
                textAlign: TextAlign.center,
              )
            : null,
        items: users
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: SizedBox(
                    width: ThreadMembersDrawer.getWidth(context) * 0.85,
                    child: UserTile(
                      user: e,
                      showDmButton: false,
                      actions: [],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
