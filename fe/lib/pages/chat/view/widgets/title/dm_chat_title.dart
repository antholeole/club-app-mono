import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:flutter/material.dart';

class DmChatTitle extends StatelessWidget {
  final Thread? _thread;

  const DmChatTitle({Key? key, Thread? thread})
      : _thread = thread,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatTitle(
      thread: _thread,
    );
  }
}
