import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/simple_message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPageMessageDisplay extends StatelessWidget {
  final Message _message;
  final void Function(Message, LayerLink)? _onHeld;
  final LayerLink link = LayerLink();

  ChatPageMessageDisplay(
      {required Message message, void Function(Message, LayerLink)? onHeld})
      : _message = message,
        _onHeld = onHeld;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: GestureDetector(
        onLongPress: () {
          if (_onHeld != null) {
            _onHeld!(_message, link);
          }
        },
        child: SimpleMessageDisplay(
          message: _message,
        ),
      ),
    );
  }
}
