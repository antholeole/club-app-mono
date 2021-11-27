import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/thread_members_drawer.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:fe/pages/chat/view/widgets/title/club_chat_title.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final Group group;

  late final ThreadCubit _threadCubit;

  final ScrollController _scrollController = ScrollController();

  ChatPage({required this.group}) {
    _threadCubit = ThreadCubit(group: group);
  }

  static MainScaffoldParts scaffoldWidgets(BuildContext context) {
    final group = BlocProvider.of<MainCubit>(context, listen: true).state.join(
        (p0) => null,
        (p0) => null,
        (_) => null,
        (mwc) => mwc.club,
        (p0) => null,
        (mwdm) => mwdm.dm);

    final thread =
        BlocProvider.of<ThreadCubit>(context, listen: true).state.thread;

    final List<ActionButton> actionButtons = [];
    if (thread != null) {
      actionButtons.add(ActionButton(
          icon: Icons.group, onClick: Scaffold.of(context).openEndDrawer));
    }

    if (group is Club) {
      return MainScaffoldParts(
          actionButtons: actionButtons,
          endDrawer: thread != null
              ? ThreadMembersDrawer(
                  thread: thread,
                  group: group,
                )
              : null,
          titleBarWidget: GestureDetector(
              onTap: () => context.read<PageCubit>().bottomSheet(context),
              child: ClubChatTitle(
                thread: thread,
                onClick: () => context.read<PageCubit>().bottomSheet(context),
              )));
    } else {
      return MainScaffoldParts(
        actionButtons: actionButtons,
        titleBarWidget: ChatTitle(thread: thread),
        endDrawer: thread != null
            ? ThreadMembersDrawer(
                group: group!, //safety: if there's a thread, there's a group
                thread: thread,
              )
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _threadCubit,
        ),
        BlocProvider(
            create: (_) =>
                MessageOverlayCubit(scrollController: _scrollController))
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    updateScaffold(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<MainCubit, MainState>(listener: (context, state) {
            state.join(
                (_) => null,
                (_) => null,
                (_) => null,
                (mpwg) => context.read<ThreadCubit>().newGroup(mpwg.club),
                (_) => null,
                (mpwdm) => context.read<ThreadCubit>().newGroup(mpwdm.dm));
          }),
          BlocListener<PageCubit, PageState>(listener: (context, state) {
            state.join((_) => null, (cps) {
              if (cps.thread != null) {
                context.read<ThreadCubit>().switchToThread(cps.thread!);
              }
            });
          }),
        ],
        child: BlocConsumer<ThreadCubit, ThreadState>(
          listener: (_, state) => context.read<PageCubit>().currentThread =
              state.join((_) => null, (wts) => wts.thread),
          builder: (context, state) => state.join((_) => Container(), (wts) {
            return MultiProvider(
                providers: [
                  Provider<Thread>.value(value: wts.thread),
                  ProxyProvider<Thread, ChatBloc>(
                    create: (BuildContext context) =>
                        ChatBloc(thread: context.read<Thread>()),
                    update: (BuildContext _, Thread thread, ChatBloc? value) =>
                        ChatBloc(thread: thread),
                  ),
                  ProxyProvider<ChatBloc, SendCubit>(
                    create: (BuildContext context) => SendCubit(
                        chatBloc: context.read<ChatBloc>(),
                        thread: context.read<Thread>()),
                    update: (BuildContext context, ChatBloc chatBloc,
                            SendCubit? value) =>
                        SendCubit(
                            thread: context.read<Thread>(), chatBloc: chatBloc),
                  )
                ],
                builder: (context, _) => const FooterLayout(
                      footer: KeyboardAttachable(
                        child: ChatBar(),
                      ),
                      child: Chats(),
                    ));
          }),
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
