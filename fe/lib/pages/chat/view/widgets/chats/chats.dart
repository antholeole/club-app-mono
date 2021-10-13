import 'dart:ui';

import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/message_overlay_display.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/sending_message.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/errors/unreachable_state.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';
import 'message/chat_page_message_display.dart';

class Chats extends StatefulWidget {
  static const String ERROR_COPY = 'There was an error while fetching chats.';
  static const String NO_MESSAGES_COPY = 'No messages yet.';
  static const String NO_THREAD_COPY = 'No thread selected.';

  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _handler = getIt<Handler>();

  late ScrollController _scrollController;

  late MessageOverlayCubit _messsageOverlayCubit;

  @override
  void initState() {
    _messsageOverlayCubit = context.read<MessageOverlayCubit>();
    _scrollController = _messsageOverlayCubit.scrollController;
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _messsageOverlayCubit.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: BlocBuilder<SendCubit, List<SendState>>(
        builder: (_, unsents) => BlocConsumer<ChatBloc, ChatState>(
          listener: (_, chatState) => chatState.join(
              (_) => null,
              (fmf) => _handler.handleFailure(fmf.failure, context),
              (_) => null,
              (_) => null),
          builder: (_, state) {
            return state.join(
                (fm) => _buildChats(fm, unsents),
                (fmf) => _buildError(fmf.failure),
                (_) => _buildLoading(),
                (_) => throw UnreachableStateError(_));
          },
        ),
      ),
    );
  }

  Widget _buildChats(FetchedMessages messagesState, List<SendState> unsents) {
    int itemCount;

    if (messagesState.messages.isEmpty && unsents.isEmpty) {
      return _buildNoChats();
    }

    if (messagesState.hasReachedMax) {
      itemCount = messagesState.messages.length;
    } else {
      itemCount = messagesState.messages.length + 1;
    }

    itemCount += unsents.length;

    return MessageOverlayDisplay(
      child: ListView.builder(
          reverse: true,
          controller: _scrollController,
          itemCount: itemCount,
          itemBuilder: (context, i) {
            if (i < unsents.length) {
              return SendingMessageDisplay(
                  sendState: unsents[unsents.length - 1 - i]);
            }

            if (i >= messagesState.messages.length + unsents.length) {
              context.read<ChatBloc>().add(const FetchMessagesEvent());
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Loader(),
              );
            }

            final message = messagesState.messages.toList()[i - unsents.length];

            return ChatPageMessageDisplay(
                message: message,
                sentBySelf:
                    message.user.id == context.read<UserCubit>().user.id);
          }),
    );
  }

  Widget _buildError(Failure failure) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              Chats.ERROR_COPY,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        PillButton(
          text: 'retry',
          onClick: () => context.read<ChatBloc>().add(const RetryEvent()),
          icon: Icons.refresh,
        ),
      ],
    ));
  }

  Widget _buildNoChats() {
    final copy = [];

    if (context.read<ThreadCubit>().state.thread != null) {
      copy.addAll(
          [Chats.NO_MESSAGES_COPY, 'Send one to start the conversation!']);
    } else {
      copy.add(Chats.NO_THREAD_COPY);
    }

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: copy
              .map((e) => Text(e, style: Theme.of(context).textTheme.caption))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: Loader());
  }

  void _onScroll() {
    final chatCubit = context.read<ChatBloc>();

    chatCubit.appendingNewMessages = _scrollController.offset <= 0;
  }
}
