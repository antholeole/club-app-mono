import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/features/message_overlay/cubit/message_overlay_state.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/overlay/message_overlay_holder.dart';
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
      listener: (context, state) =>
          state.when(none: _dismissOverlay, toggled: _displayOverlay),
      child: widget._child,
    );
  }

  void _displayOverlay(LayerLink link, Message message) {
    FocusScope.of(context).unfocus();
    if (_currentMessageOverlay != null) {
      _currentMessageOverlay!.remove();
    }

    HapticFeedback.lightImpact();

    _currentMessageOverlay = OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (_) => MultiProvider(
                providers: [
                  BlocProvider.value(value: context.read<ToasterCubit>()),
                  Provider.value(value: context.read<Thread>())
                ],
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: MessageOverlayHolder(
                      dismissSelf: _dismissOverlay,
                      layerLink: link,
                      selfId: context.read<UserCubit>().user.id,
                      message: message),
                )));

    Overlay.of(context)!.insert(_currentMessageOverlay!);
  }

  void _dismissOverlay() {
    _currentMessageOverlay?.remove();
    _currentMessageOverlay = null;
    context.read<MessageOverlayCubit>().dismissOverlay();
  }
}
