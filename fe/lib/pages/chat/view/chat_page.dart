import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/chat_bar.dart';
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
  late final ChatBloc _chatBloc;

  ChatPage({required this.group}) {
    _threadCubit = ThreadCubit(group: group);
    _chatBloc = ChatBloc(threadCubit: _threadCubit);
  }

  static MainScaffoldParts scaffoldWidgets(BuildContext context) {
    final group = Provider.of<MainCubit>(context, listen: true).state.join(
        (p0) => null,
        (p0) => null,
        (_) => null,
        (mwc) => mwc.club,
        (p0) => null,
        (mwdm) => mwdm.dm);

    final thread = Provider.of<ThreadCubit>(context, listen: true).state.thread;

    if (group is Club) {
      return MainScaffoldParts(
          actionButtons: [],
          endDrawer: Container(
            color: Colors.red,
          ),
          titleBarWidget: GestureDetector(
              onTap: () => context.read<PageCubit>().bottomSheet(context),
              child: ClubChatTitle(
                thread: thread,
                shouldBeOpen: context.read<PageCubit>().isClosed,
                onClick: () => context.read<PageCubit>().bottomSheet(context),
              )));
    } else {
      return MainScaffoldParts(titleBarWidget: ChatTitle(thread: thread));
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
          create: (_) => _chatBloc,
        )
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
        child: BlocBuilder<ThreadCubit, ThreadState>(
          builder: (context, state) => state.join(
              (_) => Container(),
              (_) => BlocProvider<SendCubit>(
                    create: (_) => SendCubit(
                        threadCubit: context.read<ThreadCubit>(),
                        chatBloc: context.read<ChatBloc>()),
                    child: const FooterLayout(
                      footer: KeyboardAttachable(child: ChatBar()),
                      child: Chats(),
                    ),
                  )),
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
