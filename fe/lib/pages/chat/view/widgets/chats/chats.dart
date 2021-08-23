import 'dart:ui';

import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';
import 'message/chat_page_message_display.dart';
import 'message/hold_overlay/message_overlay.dart';

class Chats extends StatefulWidget {
  final Thread _thread;

  const Chats({Key? key, required Thread thread})
      : _thread = thread,
        super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _handler = getIt<Handler>();

  OverlayEntry? _currentMessageOverlay;

  late PagingController<DateTime, Message> _pagingController;

  @override
  void didChangeDependencies() {
    _setupPagingController();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _setupPagingController();
    super.initState();
  }

  @override
  void didUpdateWidget(Chats oldWidget) {
    if (oldWidget._thread != widget._thread) {
      _setupPagingController();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _setupPagingController() {
    _pagingController = PagingController(
        firstPageKey: DateTime.now().add(const Duration(hours: 5)),
        invisibleItemsThreshold: 3);
    _pagingController.addPageRequestListener(
        (before) => context.read<ChatCubit>().getChats(widget._thread, before));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThreadCubit, ThreadState>(
        listener: (context, _) => _pagingController.refresh(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          child: BlocListener<ChatCubit, ChatState>(
            listener: (context, state) => state.join(
                (_) => null,
                (cfm) =>
                    _pagingController.appendPage(cfm.messages, cfm.lastSentAt),
                (cfmf) {
              _pagingController.error = cfmf.failure;
              _handler.handleFailure(cfmf.failure, context,
                  withPrefix: 'failed fetching messages');
            }),
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
                    onHeld: (message, layerLink) =>
                        _onTappedMessage(message, layerLink, context),
                  );
                },
              ),
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

    if (context.read<ThreadCubit>().state.thread != null) {
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
}
