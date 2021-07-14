import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_buttons.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_text_field.dart';
import 'package:fe/pages/chat/widgets/chat_input/send_button.dart';
import 'package:fe/pages/main/main_helpers/ws/ws_provider.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _settingsIsOpen = true;
  bool _loadingSend = false;

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
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 1))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                loading: _loadingSend,
                isSendable: _controller.text.isNotEmpty,
                onClick: _onSend)
          ],
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
    UuidType? to = context.read<ChatCubit>().state.thread?.id;

    if (to == null) {
      Toaster.of(context).errorToast('No thread selected! Nowhere to send!');
      return;
    }

    try {
      setState(() {
        _loadingSend = true;
      });

      await WsProvider.of(context)!
          .wsClient
          .send(WsMessageMessage(message: _controller.text, toId: to));
      _controller.clear();
    } on Failure catch (f) {
      handleFailure(f, context);
    } finally {
      setState(() {
        _loadingSend = false;
      });
    }
  }
}
