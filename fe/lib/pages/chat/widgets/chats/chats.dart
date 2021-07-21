import 'dart:ui';

import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/chat_service.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/chats/message/chat_page_message_display.dart';
import 'package:fe/pages/chat/widgets/chats/message/hold_overlay/message_overlay.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _chatService = getIt<ChatService>();

  final PagingController<DateTime, Message> _pagingController =
      PagingController(
          firstPageKey: DateTime.now().add(const Duration(hours: 5)),
          invisibleItemsThreshold: 3);

  OverlayEntry? currentMessageOverlay;

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          _pagingController.refresh();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          child: PagedListView<DateTime, Message>(
            reverse: true,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Message>(
              firstPageErrorIndicatorBuilder: _buildFirstPageError,
              noItemsFoundIndicatorBuilder: _buildNoChats,
              newPageProgressIndicatorBuilder: _buildLoading,
              firstPageProgressIndicatorBuilder: _buildLoading,
              itemBuilder: (context, message, index) {
                return ChatPageMessageDisplay(
                  message: message,
                  onHeld: _onTappedMessage,
                );
              },
            ),
          ),
        ));
  }

  Widget _buildFirstPageError(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              'There was an error while fetching chats.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        PillButton(
          text: 'retry',
          onClick: () => _pagingController.retryLastFailedRequest(),
          icon: Icons.refresh,
        ),
      ],
    ));
  }

  Widget _buildNoChats(BuildContext context) {
    final copy = [];

    if (context.read<ChatCubit>().state.thread != null) {
      copy.addAll(['No messages yet.', 'Send one to start the conversation!']);
    } else {
      copy.add('No thread selected.');
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

  Widget _buildLoading(BuildContext _) {
    return const Center(child: Loader());
  }

  void _onTappedMessage(Message message, LayerLink link) {
    FocusScope.of(context).requestFocus();
    if (currentMessageOverlay != null) {
      currentMessageOverlay!.remove();
    }

    currentMessageOverlay = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: MessageOverlay(
            dismissSelf: () {
              currentMessageOverlay!.remove();
              currentMessageOverlay = null;
            },
            link: link,
            message: message),
      ),
    );
    HapticFeedback.lightImpact();
    Overlay.of(context)!.insert(currentMessageOverlay!);
  }

  Future<void> _fetchPage(DateTime pageKey) async {
    final thread = context.read<ChatCubit>().state.thread;

    if (thread == null) {
      _pagingController.appendPage([], DateTime.now());
      return;
    }

    try {
      final chats = await _chatService.getChats(thread, pageKey);

      if (chats.isNotEmpty) {
        _pagingController.appendPage(chats, chats.last.sentAt);
      } else {
        _pagingController.appendPage([], null);
      }
    } on Failure catch (f) {
      _pagingController.error = f;
      handleFailure(f, context);
    }
  }
}
