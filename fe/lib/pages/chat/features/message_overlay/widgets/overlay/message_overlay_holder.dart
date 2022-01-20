import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/overlay/options/message_options_overlay.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/overlay/reactions/message_reaction_overlay.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';

const Duration _ANIMATION_DURATION = Duration(milliseconds: 75);

class MessageOverlayHolder extends StatefulWidget {
  final VoidCallback _dismissSelf;
  final LayerLink _layerLink;
  final Message _message;
  final UuidType _selfId;

  const MessageOverlayHolder({
    Key? key,
    required VoidCallback dismissSelf,
    required LayerLink layerLink,
    required UuidType selfId,
    required Message message,
  })  : _dismissSelf = dismissSelf,
        _selfId = selfId,
        _layerLink = layerLink,
        _message = message,
        super(key: key);

  @override
  State<MessageOverlayHolder> createState() => _MessageOverlayHolderState();
}

class _MessageOverlayHolderState extends State<MessageOverlayHolder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late Animation _colorAnimation;

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_animationController.isCompleted) {
      _animationController.forward();
    }
  }

  void _prepareAnimations() {
    _animationController =
        AnimationController(vsync: this, duration: _ANIMATION_DURATION)
          ..addListener(() => setState(() {}));
    _colorAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.black.withAlpha(50))
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Listener(
          onPointerDown: (_) => _leave(),
          child: Container(color: _colorAnimation.value),
        ),
      ),
      MessageOptionsOverlay(
          dismissSelf: widget._dismissSelf,
          animationController: _animationController,
          link: widget._layerLink,
          message: widget._message),
      MessageReactionOverlay(
          link: widget._layerLink,
          message: widget._message,
          animationController: _animationController,
          selfId: widget._selfId,
          dismissSelf: widget._dismissSelf)
    ]);
  }

  void _leave() {
    _animationController.reverse().then((_) => widget._dismissSelf());
  }
}
