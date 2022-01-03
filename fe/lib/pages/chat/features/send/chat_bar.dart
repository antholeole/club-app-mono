import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/features/send/widgets/chat_input/sendable/chat_buttons.dart';
import 'package:fe/pages/chat/features/send/widgets/chat_input/sendable/chat_text_field.dart';
import 'package:fe/pages/chat/features/send/widgets/chat_input/sendable/image_presend.dart';
import 'package:fe/pages/chat/features/send/widgets/chat_input/sendable/send_button.dart';
import 'package:fe/pages/chat/features/send/widgets/chat_input/unsendable/unsendable_chatbar.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../service_locator.dart';
import 'cubit/send_cubit.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final Handler _handler = getIt<Handler>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  XFile? _image;

  bool _hasContent = true;
  bool _manuallyShowingSettings = false;

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
          child: buildContent(context.watch<Thread>()),
        ),
      ),
    );
  }

  Widget buildContent(Thread thread) {
    if (thread.isViewOnly) {
      return const UnsendableChatbar(reason: UnsendableReason.ViewOnly);
    } else {
      return Row(
        children: [
          ChatButtons(
            isOpen: !_hasContent || _manuallyShowingSettings,
            manuallyShowButtons: () => setState(() {
              _manuallyShowingSettings = true;
            }),
            pickedImage: (image) => setState(() {
              _hasContent = true;
              _manuallyShowingSettings = false;
              _image = image;
            }),
          ),
          Expanded(
              child: Column(
            children: [
              if (_image != null) ImagePresend(image: _image!),
              ChatTextField(
                focusNode: _focusNode,
                controller: _controller,
              ),
            ],
          )),
          SendButton(isSendable: _hasContent, onClick: _onSend)
        ],
      );
    }
  }

  void _onTextUpdate() {
    final hasText = _controller.text.isNotEmpty;
    final hasImage = _image != null;

    setState(() {
      _hasContent = hasText || hasImage;
      _manuallyShowingSettings = false;
    });
  }

  Future<void> _onSend() async {
    if (_controller.text.isNotEmpty) {
      try {
        final text = _controller.text;
        _controller.clear();
        await context.read<SendCubit>().sendText(text);
      } on Failure catch (f) {
        _handler.handleFailure(f, context, withPrefix: 'error sending message');
      }
    }

    if (_image != null) {
      try {
        final image = _image!;
        setState(() {
          _image = null;
        });
        await context.read<SendCubit>().sendImage(image);
      } on Failure catch (f) {
        _handler.handleFailure(f, context, withPrefix: 'error sending file');
      }
    }
  }
}
