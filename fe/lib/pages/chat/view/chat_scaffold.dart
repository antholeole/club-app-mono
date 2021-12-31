import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/chat_right_drawer.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:fe/pages/chat/view/widgets/title/club_chat_title.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/view/main_scaffold.dart';
import 'package:fe/pages/scaffold/view/widgets/scaffold_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScaffold extends StatelessWidget {
  final Widget _child;
  final Group _group;
  final Thread? _thread;

  const ChatScaffold(
      {Key? key, required Widget child, Thread? thread, required Group group})
      : _child = child,
        _thread = thread,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ScaffoldButton> actionButtons = [];
    if (_thread != null) {
      actionButtons.add(ScaffoldButton(
        icon: Icons.group,
        onPressed: (context) => Scaffold.of(context).openEndDrawer(),
      ));
    }

    return MainScaffold(
        titleBarWidget: _group.map(
            dm: (_) => ChatTitle(thread: _thread),
            club: (_) => GestureDetector(
                onTap: () => context.read<PageCubit>().bottomSheet(context),
                child: ClubChatTitle(
                  thread: _thread,
                  onClick: () => context.read<PageCubit>().bottomSheet(context),
                ))),
        endDrawer: _thread != null
            ? ChatRightDrawer(
                thread: _thread!,
                group: _group,
              )
            : null,
        actionButtons: actionButtons,
        child: _child);
  }
}
