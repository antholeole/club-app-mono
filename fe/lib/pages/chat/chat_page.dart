import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/gql/query_thread_by_id.data.gql.dart';
import 'package:fe/gql/query_thread_by_id.req.gql.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/widgets/chat_title.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:ferry/ferry.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _gqlClient = getIt<Client>();
  Group? _currentGroup;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused &&
        _currentGroup != null &&
        context.read<ChatCubit>().state.thread != null) {
      _cacheThread(_currentGroup!, context.read<ChatCubit>().state.thread!);
    }
  }

  @override
  void didChangeDependencies() {
    if (AutoRouter.of(context).innerRouterOf(Main.name)!.topRoute.name ==
        ChatRoute.name) {
      context
          .read<MainScaffoldCubit>()
          .updateMainScaffold(_mainScaffoldParts());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainPageBloc, MainPageState>(
      listener: (context, state) {
        final currentThread = context.read<ChatCubit>().state.thread;

        context.read<ChatCubit>().setThread(null);

        if (_currentGroup != null && currentThread != null) {
          _cacheThread(_currentGroup!, currentThread);
        }

        if (state is MainPageWithGroup) {
          context.read<ChatCubit>().setThread(null);
          _currentGroup = state.group;
          _getCachedThread(state.group).then((thread) {
            context.read<ChatCubit>().setThread(thread);
          });
        }
      },
      child: FooterLayout(
        footer: KeyboardAttachable(child: ChatBar()),
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  MainScaffoldUpdate _mainScaffoldParts() {
    return MainScaffoldUpdate(
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

  String _getCacheThreadKey(Group group) {
    return 'group:${group.id.uuid}:thread';
  }

  Future<void> _cacheThread(Group group, Thread currentThread) async {
    final key = _getCacheThreadKey(group);
    await _sharedPrefrences.setString(key, currentThread.id.uuid);
  }

  Future<Thread?> _getCachedThread(Group group) async {
    final key = _getCacheThreadKey(group);
    final threadId = _sharedPrefrences.getString(key);

    if (threadId == null) {
      return null;
    }

    final threadFromServer = await _gqlClient
        .request(GQueryThreadByIdReq((q) => q
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..vars.threadId = UuidType(threadId)))
        .first;

    if (threadFromServer.data == null) {
      return null;
    }

    return Thread(
        name: threadFromServer.data!.group_threads_by_pk!.name,
        id: threadFromServer.data!.group_threads_by_pk!.id);
  }
}
