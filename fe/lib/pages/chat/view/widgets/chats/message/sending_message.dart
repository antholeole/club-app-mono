import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/message_display.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SendingMessageDisplay extends StatelessWidget {
  final SendState _sendState;

  const SendingMessageDisplay({required SendState sendState, Key? key})
      : _sendState = sendState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
                message: Message(
                    user: context.read<UserCubit>().user,
                    id: UuidType.generate(), //does't matter
                    message: _sendState.message.message,
                    isImage: false,
                    createdAt: clock.now(),
                    updatedAt: clock.now()),
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
