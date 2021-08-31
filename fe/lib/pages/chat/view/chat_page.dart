import 'package:fe/data/models/group.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/view/widgets/chat_title.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final Group group;

  const ChatPage({required this.group});

  static MainScaffoldParts scaffoldWidgets(BuildContext context) {
    return MainScaffoldParts(
        actionButtons: [],
        endDrawer: Container(
          color: Colors.red,
        ),
        titleBarWidget: GestureDetector(
            onTap: () => context.read<PageCubit>().bottomSheet(context),
            child: ChatTitle(chatProviderContext: context)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThreadCubit(group: group),
        ),
        BlocProvider(
          create: (_) => ChatCubit(),
        ),
      ],
      child: const ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  //allows us to use this in didChangeAppLifecycleState
  //without lifecycle errors.
  Group? currentGroup;
  ThreadCubit? threadCubit;
  PageCubit? pageCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    updateScaffold(context);

    if (threadCubit != null) {
      pageCubit?.addThreadCubit(threadCubit!);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pageCubit?.removeThreadCubit();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (threadCubit != null &&
        state == AppLifecycleState.paused &&
        currentGroup != null) {
      threadCubit!.cacheThread();
    }
  }

  @override
  Widget build(BuildContext context) {
    threadCubit = context.read<ThreadCubit>();
    pageCubit = context.read<PageCubit>();
    final thread = context.watch<ThreadCubit>().state.thread;

    return MultiBlocListener(
        listeners: [
          BlocListener<MainCubit, MainState>(listener: (context, state) {
            if (state.group != null) {
              context.read<ThreadCubit>().newGroup(state.group!);
              currentGroup = state.group;
            }
          }),
          BlocListener<PageCubit, PageState>(listener: (context, state) {
            state.join((_) => null, (cps) {
              if (cps.thread != null) {
                context.read<ThreadCubit>().switchToThread(cps.thread!);
              }
            });
          }),
        ],
        child: FooterLayout(
          footer: const KeyboardAttachable(child: ChatBar()),
          child: thread != null ? const Chats() : Container(),
        ));
  }

  void updateScaffold(BuildContext context) {
    context.read<PageCubit>().state.join(
        (_) => null,
        (_) => context
            .read<ScaffoldCubit>()
            .updateMainParts(ChatPage.scaffoldWidgets(context)));
  }
}
