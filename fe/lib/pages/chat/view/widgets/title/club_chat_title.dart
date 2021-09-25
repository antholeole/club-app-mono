import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';

import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:flutter/material.dart';

class ClubChatTitle extends StatelessWidget {
  final bool _shouldBeOpen;
  final VoidCallback _onClick;
  final Thread? _thread;

  const ClubChatTitle(
      {Key? key,
      required VoidCallback onClick,
      required bool shouldBeOpen,
      Thread? thread})
      : _shouldBeOpen = shouldBeOpen,
        _thread = thread,
        _onClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.balcony, color: Colors.transparent),
          ChatTitle(
            thread: _thread,
          ),
          FlippableIcon(
              icon: const Icon(Icons.chevron_right),
              onClick: () => _onClick,
              flipped: _shouldBeOpen),
        ]);
  }
}
