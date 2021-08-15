import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTitle extends StatelessWidget {
  @visibleForTesting
  static const String NO_THREAD_TEXT = 'Select Thread';

  final BuildContext _chatProviderContext;

  const ChatTitle({Key? key, required BuildContext chatProviderContext})
      : _chatProviderContext = chatProviderContext,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool shouldBeOpen =
        _chatProviderContext.watch<ChatBottomSheetCubit>().state.isOpen;

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.balcony, color: Colors.transparent),
          _buildTitleWidget(_chatProviderContext),
          FlippableIcon(
              icon: const Icon(Icons.chevron_right),
              onClick: () =>
                  _chatProviderContext.read<PageCubit>().bottomSheet(context),
              flipped: shouldBeOpen),
        ]);
  }

  Widget _buildTitleWidget(BuildContext context) {
    final thread = context.watch<ThreadCubit>().state.thread;

    Text text;
    if (thread == null) {
      text = const Text(
        ChatTitle.NO_THREAD_TEXT,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      text = Text(
        thread.name,
      );
    }

    return text;
  }
}
