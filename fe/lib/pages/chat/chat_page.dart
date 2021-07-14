import 'package:fe/data/models/group.dart';
import 'package:fe/pages/chat/chat_service.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/widgets/chat_title.dart';
import 'package:fe/pages/chat/widgets/chats/chats.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/scaffold_cubit.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';

class ChatPage extends StatefulWidget {
  final Group group;

  const ChatPage({required this.group});

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
            child: const ChatTitle()));
  }
}

class _ChatPageState extends State<ChatPage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<ChatPage> {
  final ChatService _chatService = getIt<ChatService>();
  late void Function() updateScaffold;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    updateScaffold = () {
      if (context.read<PageCubit>().state.currentPage == 0) {
        context
            .read<ScaffoldCubit>()
            .updateMainParts(ChatPage.scaffoldWidgets(context));
      }
    };

    final newThread = _chatService.getCachedThread(widget.group);

    context.read<ChatCubit>().setThread(newThread);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateScaffold();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chatService.cacheThread(
          widget.group, context.read<ChatCubit>().state.thread);
    }
  }

  @override
  void didUpdateWidget(ChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _chatService.cacheThread(
        oldWidget.group, context.read<ChatCubit>().state.thread);

    final newThread = _chatService.getCachedThread(widget.group);

    context.read<ChatCubit>().setThread(newThread);

    if (newThread != null) {
      _chatService
          .verifyStillInThread(widget.group, newThread)
          .then((inThread) {
        if (!inThread) {
          context.read<ChatCubit>().setThread(null);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<PageCubit, PageState>(
        listener: (context, state) {
          if (state.currentPage == 0) {
            updateScaffold();
          }
        },
        child: const FooterLayout(
          footer: KeyboardAttachable(child: ChatBar()),
          child: Chats(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
