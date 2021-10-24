import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/send_button.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../service_locator.dart';
import 'chat_buttons.dart';
import 'chat_text_field.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final Handler _handler = getIt<Handler>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _settingsIsOpen = true;

  @override
  void initState() {
    _controller.addListener(_onTextUpdate);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Row(
            children: [
              ChatButtons(
                  isOpen: _settingsIsOpen,
                  manuallyShowbuttons: () => setState(() {
                        _settingsIsOpen = true;
                      })),
              Expanded(
                  child: ChatTextField(
                focusNode: _focusNode,
                controller: _controller,
              )),
              SendButton(
                  isSendable: _controller.text.isNotEmpty, onClick: _onSend)
            ],
          ),
        ),
      ),
    );
  }

  void _onTextUpdate() {
    if (!_focusNode.hasFocus) {
      return;
    }

    if (_controller.text.isEmpty && !_settingsIsOpen) {
      setState(() {
        _settingsIsOpen = true;
      });
    } else {
      setState(() {
        _settingsIsOpen = false;
      });
    }
  }

  Future<void> _onSend() async {
    try {
      await context.read<SendCubit>().send(_controller.text);
      _controller.clear();
    } on Failure catch (f) {
      _handler.handleFailure(f, context);
    }
  }
}
