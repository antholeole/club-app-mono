import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/chat/chat_service.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/widgets/chat_title.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';

class ChatPage extends StatefulWidget {
  final Group _group;

  const ChatPage({required Group group}) : _group = group;

  @override
  _ChatPageState createState() => _ChatPageState();

  static MainScaffoldParts scaffoldWidgets(BuildContext context) {
    return MainScaffoldParts(
        actionButtons: [
          ActionButton(
              icon: Icons.ac_unit,
              onClick: () {
                print('hi!');
              }),
          ActionButton(
              icon: Icons.access_alarm_outlined,
              onClick: () {
                print('hi 2!');
              }),
        ],
        endDrawer: Container(
          color: Colors.red,
        ),
        titleBarWidget: GestureDetector(
            onTap: () => ChannelsBottomSheet.show(context),
            child: ChatTitle()));
  }
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final ChatService _chatService = getIt<ChatService>();
  late void Function() updateScaffold;

  @override
  void initState() {
    super.initState();
    updateScaffold = () {
      if (AutoRouter.of(context)
              .innerRouterOf<TabsRouter>(Main.name)!
              .current
              .name ==
          ChatRoute.name) {
        context
            .read<ScaffoldCubit>()
            .updateMainParts(ChatPage.scaffoldWidgets(context));
      }
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = AutoRouter.of(context).innerRouterOf<TabsRouter>(Main.name)!;

    //for the first render
    updateScaffold();

    //for remaining renders
    router.removeListener(updateScaffold);
    router.addListener(updateScaffold);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chatService.cacheThread(
          widget._group, context.read<ChatCubit>().state.thread);
    }
  }

  @override
  void didUpdateWidget(ChatPage oldWidget) {
    _chatService.cacheThread(
        oldWidget._group, context.read<ChatCubit>().state.thread);

    final newThread = _chatService.getCachedThread(widget._group);

    context.read<ChatCubit>().setThread(newThread);

    //begin a check to make sure that this thread stil exists
    if (newThread != null) {
      _chatService
          .verifyStillInThread(oldWidget._group, newThread.id)
          .then((threadExists) {
        if (!threadExists) {
          context.read<ChatCubit>().setThread(null);
        }
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FooterLayout(
      footer: KeyboardAttachable(child: ChatBar()),
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
