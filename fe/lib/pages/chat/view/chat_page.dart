import 'dart:convert';

import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/chat_scaffold.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Group>();
    final currentThread = context
        .watch<PageCubit>()
        .state
        .maybeWhen(orElse: () => null, chat: (thread) => thread);

    return HydratedBuilder<Thread>(
      '${context.watch<Group>().id.uuid}+thread',
      deserialize: (thread) => Thread.fromJson(json.decode(thread)),
      serialize: (thread) => json.encode(thread.toJson()),
      initalValue: currentThread,
      onEmpty: (context) {
        context.read<PageCubit>().currentThread = null;
        return ChatScaffold(
          group: group,
          thread: null,
          child: Container(),
        );
      },
      onBuild: (context, thread) {
        context.read<PageCubit>().currentThread = thread;
        return ChatScaffold(
          group: group,
          thread: thread,
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
        );
      },
    );
  }
}
