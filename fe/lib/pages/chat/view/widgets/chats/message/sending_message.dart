import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/simple_message_display.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendingMessageDisplay extends StatelessWidget {
  final SendState _sendState;

  const SendingMessageDisplay({required SendState sendState, Key? key})
      : _sendState = sendState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SimpleMessageDisplay.SELF_SENT_COLOR,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade600,
                BlendMode.lighten,
              ),
              child: SimpleMessageDisplay(
                sender: UserProvider.of(context).user,
                message: _sendState.message.message,
                sentBySelf: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: _sendState.join(
                (_) => const Loader(
                      size: 14,
                    ),
                (sf) => GestureDetector(
                      onTap: sf.resend,
                      child: const Icon(Icons.refresh),
                    )),
          ),
        ],
      ),
    );
  }
}
