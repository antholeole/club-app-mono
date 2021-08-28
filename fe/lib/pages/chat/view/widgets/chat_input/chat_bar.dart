import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/send_button.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
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
    UuidType? to = context.read<ThreadCubit>().state.thread?.id;

    if (to == null) {
      context.read<ToasterCubit>().add(Toast(
            message: 'No thread selected! Nowhere to send!',
            type: ToastType.Warning,
          ));

      return;
    }

    try {
      setState(() {
        _loadingSend = true;
      });

      _controller.clear();
    } on Failure catch (f) {
      _handler.handleFailure(f, context);
    } finally {
      setState(() {
        _loadingSend = false;
      });
    }
  }
}
