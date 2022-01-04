import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/features/message_overlay/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/view/widgets/message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ChatPageMessageDisplay extends StatefulWidget {
  final Message _message;
  final bool? _sentBySelf;

  const ChatPageMessageDisplay(
      {required Message message, bool? sentBySelf, Key? key})
      : _message = message,
        _sentBySelf = sentBySelf,
        super(key: key);

  @override
  State<ChatPageMessageDisplay> createState() => _ChatPageMessageDisplayState();
}

class _ChatPageMessageDisplayState extends State<ChatPageMessageDisplay>
    with AutomaticKeepAliveClientMixin {
  //the layer link MUST be an element of the state;
  //this is because when this message gets re-rendered, we want to
  //keep the old layer link as opposed to creating a new one
  //in order for the overlay to not "lose" this message by
  //having the old layerLink not have a target.
  final LayerLink _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onLongPress: () => context
            .read<MessageOverlayCubit>()
            .addSettingsOverlay(layerLink: _link, message: widget._message),
        onTap: () => context
            .read<MessageOverlayCubit>()
            .addReactionOverlay(layerLink: _link, message: widget._message),
        child: MessageDisplay(
          message: widget._message,
          sentBySelf: widget._sentBySelf ?? false,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive =>
      widget._message.map(text: (_) => false, image: (_) => true);
}
