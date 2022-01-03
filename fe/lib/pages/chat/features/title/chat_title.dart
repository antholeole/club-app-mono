import 'package:fe/data/models/thread.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  @visibleForTesting
  static const String NO_THREAD_TEXT = 'Select Thread';

  final Thread? _thread;

  const ChatTitle({Key? key, Thread? thread})
      : _thread = thread,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Text text;
    if (_thread == null) {
      text = const Text(
        NO_THREAD_TEXT,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      text = Text(
        _thread!.name,
      );
    }

    return text;
  }
}
