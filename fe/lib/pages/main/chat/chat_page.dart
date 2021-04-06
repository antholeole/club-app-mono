import 'package:fe/data_classes/chat.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  Chat chat;

  ChatPage({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("chat"),
    );
  }
}
