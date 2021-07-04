import 'dart:ui';

import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/widgets/chats/message/message_display.dart';
import 'package:flutter/material.dart';

class MessageOverlay extends StatelessWidget {
  final LayerLink link;
  final Message message;
  final void Function() dismissSelf;

  const MessageOverlay(
      {Key? key,
      required this.dismissSelf,
      required this.link,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Listener(
          onPointerDown: (_) => dismissSelf(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
            child: Container(color: Color(0x06000000)),
          ),
        ),
      ),
      CompositedTransformFollower(
        link: link,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MessageDisplay(
            message: message,
          ),
        ),
      ),
    ]);
  }
}
