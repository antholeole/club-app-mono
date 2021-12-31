import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/club_drawer/club_drawer.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/dm_drawer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ChatRightDrawer extends StatelessWidget {
  final Thread _thread;
  final Group _group;

  const ChatRightDrawer(
      {Key? key, required Thread thread, required Group group})
      : _thread = thread,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              _thread.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 30,
            ),
            Expanded(
                child: Provider<Thread>(
              create: (_) => _thread,
              child: SingleChildScrollView(
                  child: _group is Club
                      ? ClubDrawer(club: _group as Club)
                      : const DmDrawer()),
            ))
          ],
        ),
      ),
    );
  }
}
