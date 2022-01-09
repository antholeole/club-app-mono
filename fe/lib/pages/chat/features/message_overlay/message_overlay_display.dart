import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/features/message_overlay/cubit/message_overlay_state.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/hold_overlay/message_options_overlay.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/reactions_overlay/message_reaction_overlay.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/message_overlay_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageOverlayCubit, MessageOverlayState>(
      listener: (context, state) => state.when(
          none: _dismissOverlay,
          settings: _onDisplaySettings,
          reactions: _onDisplayReaction),
      child: widget._child,
    );
  }

  void _onDisplayReaction(LayerLink link, Message message) {
    _displayOverlay(
        MessageReactionOverlay(
            link: link,
            message: message,
            selfId: context.read<UserCubit>().user.id,
            dismissSelf: _dismissOverlay),
        message);
  }

  void _onDisplaySettings(LayerLink link, Message message) {
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
    FocusScope.of(context).unfocus();
    if (_currentMessageOverlay != null) {
      _currentMessageOverlay!.remove();
    }

    _currentMessageOverlay = OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (_) => MultiProvider(providers: [
              BlocProvider.value(value: context.read<ToasterCubit>()),
              Provider.value(value: context.read<Thread>())
            ], child: widget));

    Overlay.of(context)!.insert(_currentMessageOverlay!);
  }

  void _dismissOverlay() {
    _currentMessageOverlay?.remove();
    _currentMessageOverlay = null;
    context.read<MessageOverlayCubit>().dismissOverlay();
  }
}
