import 'dart:convert';

import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/chat_scaffold.dart';
import 'package:fe/pages/chat/features/notification_freeze/notification_freezer.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_cubit.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_state.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/chat_display/chats.dart';
import 'features/chat_display/cubit/chat_cubit.dart';
import 'features/message_overlay/cubit/message_overlay_cubit.dart';
import 'features/send/chat_bar.dart';
import 'features/send/cubit/send_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<Group>().map(
        dm: (dm) => Provider.value(
            value: Thread(name: dm.name, id: dm.id), child: _buildInner()),
        club: (club) {
          return BlocBuilder<PageCubit, PageState>(
            builder: (context, state) => HydratedBuilder<Thread>(
              '${context.watch<Group>().id.uuid}+thread',
              deserialize: (thread) => Thread.fromJson(json.decode(thread)),
              serialize: (thread) => json.encode(thread.toJson()),
              initalValue:
                  state.when(events: () => null, chat: (thread) => thread),
              onEmpty: (context) {
                context.read<PageCubit>().currentThread = null;
                return ChatScaffold(
                  child: Container(),
                );
              },
              onBuild: (context, thread) {
                context.read<PageCubit>().currentThread = thread;
                return _buildInner();
              },
            ),
          );
        });
  }

  Widget _buildInner() {
    return NotificationFreezer(
      child: ChatScaffold(
        child: MultiProvider(
            providers: [
              BlocProvider(create: (_) => MessageOverlayCubit()),
              ProxyProvider<Thread, ChatCubit>(
                create: (BuildContext context) =>
                    ChatCubit(thread: context.read<Thread>()),
                update: (BuildContext _, Thread thread, ChatCubit? value) =>
                    ChatCubit(thread: thread),
              ),
              ProxyProvider<ChatCubit, SendCubit>(
                create: (BuildContext context) => SendCubit(
                    self: context.read<UserCubit>().user,
                    chatCubit: context.read<ChatCubit>(),
                    thread: context.read<Thread>()),
                update: (BuildContext context, ChatCubit chatCubit,
                        SendCubit? value) =>
                    SendCubit(
                        self: context.read<UserCubit>().user,
                        thread: context.read<Thread>(),
                        chatCubit: chatCubit),
              )
            ],
            builder: (context, _) => const FooterLayout(
                  footer: KeyboardAttachable(
                    child: ChatBar(),
                  ),
                  child: Chats(),
                )),
      ),
    );
  }
}
