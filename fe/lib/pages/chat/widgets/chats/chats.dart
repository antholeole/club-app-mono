import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/chat_service.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/chats/message_display.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _chatService = getIt<ChatService>();
  UuidType? _selectedMessage;

  final PagingController<DateTime, Message> _pagingController =
      PagingController(
          firstPageKey: DateTime.now().add(Duration(hours: 5)),
          invisibleItemsThreshold: 3);

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
              noItemsFoundIndicatorBuilder: _buildNoChats,
              newPageProgressIndicatorBuilder: _buildLoading,
              firstPageProgressIndicatorBuilder: _buildLoading,
              itemBuilder: (context, message, index) => MessageDisplay(
                message: message,
                selectedMessageId: _selectedMessage,
                onTapped: _onTappedMessage,
              ),
            ),
          ),
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
    return Center(child: Loader());
  }

  void _onTappedMessage(UuidType messageId) {
    if (_selectedMessage == messageId) {
      setState(() {
        _selectedMessage = null;
      });
    } else {
      setState(() {
        _selectedMessage = messageId;
      });
    }
  }

  Future<void> _fetchPage(DateTime pageKey) async {
    final thread = context.read<ChatCubit>().state.thread;

    if (thread == null) {
      _pagingController.appendPage([], DateTime.now());
      return;
    }

    final chats = await _chatService.getChats(thread, pageKey);

    if (chats.isNotEmpty) {
      _pagingController.appendPage(chats, chats.last.sentAt);
    } else {
      _pagingController.appendPage([], null);
    }
  }
}
