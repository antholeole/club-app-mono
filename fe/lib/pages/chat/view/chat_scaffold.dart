import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/chat_right_drawer.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:fe/pages/chat/view/widgets/title/club_chat_title.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/main_scaffold.dart';
import 'package:fe/pages/scaffold/widgets/scaffold_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScaffold extends StatelessWidget {
  final Widget _child;

  const ChatScaffold({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final thread = context.read<Thread?>();
    final group = context.read<Group>();

    final List<ScaffoldButton> actionButtons = [];
    if (thread != null) {
      actionButtons.add(ScaffoldButton(
        icon: Icons.group,
        onPressed: (context) => Scaffold.of(context).openEndDrawer(),
      ));
    }

    return MainScaffold(
        titleBarWidget: group.map(
            dm: (_) => ChatTitle(thread: thread),
            club: (_) => GestureDetector(
                onTap: () => context.read<PageCubit>().bottomSheet(context),
                child: ClubChatTitle(
                  thread: thread,
                  onClick: () => context.read<PageCubit>().bottomSheet(context),
                ))),
        endDrawer: thread != null
            ? ChatRightDrawer(
                thread: thread,
                group: group,
              )
            : null,
        actionButtons: actionButtons,
        child: _child);
  }
}
