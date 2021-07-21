import 'package:fe/pages/chat/cubit/bottom_sheet_open_cubit.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (bbContext, state) {
        Text text;

        if (state.thread == null) {
          text = const Text(
            'Select Thread',
            style: TextStyle(color: Colors.grey),
          );
        } else {
          final thread = state.thread!;

          text = Text(
            thread.name,
          );
        }

        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.balcony, color: Colors.transparent),
              text,
              FlippableIcon(
                  icon: const Icon(Icons.chevron_right),
                  onClick: () => ChannelsBottomSheet.show(context),
                  flipped: context.watch<ChatBottomSheetCubit>().state.isOpen),
            ]);
      },
    );
  }
}
