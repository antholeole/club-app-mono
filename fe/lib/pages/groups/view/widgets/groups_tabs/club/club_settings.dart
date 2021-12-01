import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/leave_group_button.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  @visibleForTesting
  static const String JOIN_TOKEN_HEADER = 'Join Token';

  const GroupSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Users(),
        LeaveGroupButton(),
      ],
    );
  }
}
