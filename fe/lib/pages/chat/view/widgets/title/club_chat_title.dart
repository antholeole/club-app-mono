import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ClubChatTitle extends StatelessWidget {
  final VoidCallback _onClick;
  final Thread? _thread;

  const ClubChatTitle({Key? key, required VoidCallback onClick, Thread? thread})
      : _thread = thread,
        _onClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(),
          ChatTitle(
            thread: _thread,
          ),
          GestureDetector(
              onTap: () => _onClick(),
              child: AnimatedRotation(
                  turns: !context.watch<ChatBottomSheetCubit>().state ? 0 : 0.5,
                  duration: const Duration(milliseconds: 20),
                  child: const Icon(Icons.expand_more)))
        ]);
  }
}
