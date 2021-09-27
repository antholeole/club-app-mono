import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChatPageMessageDisplay extends StatelessWidget {
  final LayerLink _link = LayerLink();

  final Message _message;
  final bool? _sentBySelf;

  ChatPageMessageDisplay({required Message message, bool? sentBySelf, Key? key})
      : _message = message,
        _sentBySelf = sentBySelf,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onLongPress: () => context
            .read<MessageOverlayCubit>()
            .addSettingsOverlay(layerLink: _link, message: _message),
        onTap: () => context
            .read<MessageOverlayCubit>()
            .addReactionOverlay(layerLink: _link, message: _message),
        child: MessageDisplay(
          message: _message,
          sentBySelf: _sentBySelf ?? false,
        ),
      ),
    );
  }
}
