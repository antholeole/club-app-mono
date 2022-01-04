import 'package:fe/pages/chat/features/send/cubit/send_state.dart';
import 'package:fe/pages/chat/view/widgets/message_display.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';

class SendingMessageDisplay extends StatefulWidget {
  final SendState _sendState;

  const SendingMessageDisplay({required SendState sendState, Key? key})
      : _sendState = sendState,
        super(key: key);

  @override
  State<SendingMessageDisplay> createState() => _SendingMessageDisplayState();
}

class _SendingMessageDisplayState extends State<SendingMessageDisplay>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: MessageDisplay.SELF_SENT_COLOR,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade600,
                BlendMode.lighten,
              ),
              child: MessageDisplay(
                message: widget._sendState.message,
                sentBySelf: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: widget._sendState.map(
                sending: (_) => const Loader(
                      size: 14,
                    ),
                failure: (sendingFailure) => GestureDetector(
                      onTap: sendingFailure.resend,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.red,
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
