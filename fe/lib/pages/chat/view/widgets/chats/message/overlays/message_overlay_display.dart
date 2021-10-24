import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/hold_overlay/message_options_overlay.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/message_reaction_overlay.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageOverlayDisplay extends StatefulWidget {
  final Widget _child;

  const MessageOverlayDisplay({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  State<MessageOverlayDisplay> createState() => _MessageOverlayDisplayState();
}

class _MessageOverlayDisplayState extends State<MessageOverlayDisplay> {
  OverlayEntry? _currentMessageOverlay;
  Message? _currentlySelectedMessage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageOverlayCubit, MessageOverlayState>(
      listener: (context, state) => state.join(
          (_) => null,
          (mos) => _onDisplaySettings(mos.message, mos.layerLink),
          (mor) => _onDisplayReaction(mor.message, mor.layerLink)),
      child: widget._child,
    );
  }

  void _onDisplayReaction(Message message, LayerLink link) {
    // if there is a currently selected message and it's the same
    // one as we just tapped, we want to dismiss only.
    if (_currentlySelectedMessage != null &&
        message == _currentlySelectedMessage) {
      _dismissOverlay();
      return;
    }

    _displayOverlay(
        MessageReactionOverlay(
            link: link,
            message: message,
            selfId: context.read<UserCubit>().user.id,
            scrollController:
                context.read<MessageOverlayCubit>().scrollController,
            dismissSelf: _dismissOverlay),
        message);
  }

  void _onDisplaySettings(Message message, LayerLink link) {
    _displayOverlay(
        Scaffold(
          backgroundColor: Colors.transparent,
          body: MessageOptionsOverlay(
              dismissSelf: _dismissOverlay, link: link, message: message),
        ),
        message);
    HapticFeedback.lightImpact();
  }

  void _displayOverlay(Widget widget, Message message) {
    _currentlySelectedMessage = message;
    FocusScope.of(context).requestFocus();
    if (_currentMessageOverlay != null) {
      _currentMessageOverlay!.remove();
    }

    _currentMessageOverlay = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (_) => BlocProvider.value(
          value: context.read<ToasterCubit>(), child: widget),
    );

    Overlay.of(context)!.insert(_currentMessageOverlay!);
  }

  void _dismissOverlay() {
    _currentMessageOverlay!.remove();
    _currentMessageOverlay = null;
    _currentlySelectedMessage = null;
    context.read<MessageOverlayCubit>().dismissOverlay();
  }
}
