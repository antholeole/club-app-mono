import 'package:fe/data/models/club.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/club_drawer/thread_roles.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/club_drawer/thread_users.dart';
import 'package:flutter/material.dart';

class ClubDrawer extends StatelessWidget {
  final Club _club;

  const ClubDrawer({Key? key, required Club club})
      : _club = club,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ThreadRoles(club: _club), const ThreadUsers()],
    );
  }
}
