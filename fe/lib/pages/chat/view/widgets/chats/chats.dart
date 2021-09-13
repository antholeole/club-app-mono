import 'dart:ui';

import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/sending_message.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/errors/unreachable_state.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';
import 'message/chat_page_message_display.dart';
import 'message/hold_overlay/message_overlay.dart';

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

  final _scrollController = ScrollController();

  OverlayEntry? _currentMessageOverlay;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
          builder: (_, state) => state.join(
              (fm) => _buildChats(fm, unsents),
              (fmf) => _buildError(fmf.failure),
              (_) => _buildLoading(),
              (_) => throw UnreachableStateError(_)),
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

    return ListView.builder(
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

          final message = messagesState.messages[i - unsents.length];

          return ChatPageMessageDisplay(
              message: message,
              sentBySelf: message.user.id == UserProvider.of(context).user.id,
              onHeld: (message, layerLink) =>
                  _onTappedMessage(message, layerLink, context));
        });
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: copy
            .map((e) => Text(e, style: Theme.of(context).textTheme.caption))
            .toList(),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: Loader());
  }

  void _onTappedMessage(Message message, LayerLink link, BuildContext context) {
    FocusScope.of(context).requestFocus();
    if (_currentMessageOverlay != null) {
      _currentMessageOverlay!.remove();
    }

    _currentMessageOverlay = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: MessageOverlay(
            dismissSelf: () {
              _currentMessageOverlay!.remove();
              _currentMessageOverlay = null;
            },
            link: link,
            message: message),
      ),
    );
    HapticFeedback.lightImpact();
    Overlay.of(context)!.insert(_currentMessageOverlay!);
  }

  void _onScroll() {
    final chatCubit = context.read<ChatBloc>();

    chatCubit.appendingNewMessages = _scrollController.offset <= 0;
  }
}
