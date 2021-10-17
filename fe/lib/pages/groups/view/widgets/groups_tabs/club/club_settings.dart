import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/join_token_tile.dart';
import 'package:fe/pages/groups/view/widgets/settings/leave_group_button.dart';
import 'package:fe/pages/groups/view/widgets/settings/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  @visibleForTesting
  static const String JOIN_TOKEN_HEADER = 'Join Token';

  const GroupSettings();

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Users(),
        if (group.admin) JoinTokenTile(),
        LeaveGroupButton(),
      ],
    );
  }
}
