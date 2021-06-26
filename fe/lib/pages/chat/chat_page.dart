import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_bar.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UuidType? threadId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
        listener: (_, state) {
          if (state is ChatSetThread) {
            setState(() {
              threadId = state.threadId;
            });
          }
        },
        child: FooterLayout(
          footer: KeyboardAttachable(child: ChatBar()),
          child: Container(
            color: Colors.red,
          ),
        ));
  }
}
