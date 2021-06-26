import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;

  const ChatTextField(
      {Key? key,
      required TextEditingController controller,
      required FocusNode focusNode})
      : _controller = controller,
        _focusNode = focusNode,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
