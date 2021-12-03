import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/leave_group_button.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/roles/role_manager.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ClubSettings extends StatelessWidget {
  @visibleForTesting
  static const String JOIN_TOKEN_HEADER = 'Join Token';

  const ClubSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (context.read<Club>().admin) RoleManager(),
        const Users(),
        LeaveGroupButton(),
      ],
    );
  }
}
