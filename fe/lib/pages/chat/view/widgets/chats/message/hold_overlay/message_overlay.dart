import 'package:fe/data/models/message.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/size_provider.dart';
import 'package:fe/stdlib/helpers/to_display_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../simple_message_display.dart';
import 'message_options.dart';

const Duration _ANIMATION_DURATION = Duration(milliseconds: 75);
const int _EDGE_INSETS_PADDING = 20;

class MessageOverlay extends StatefulWidget {
  static const BORDER_RADIUS = 8.0;
  final LayerLink link;
  final Message message;

  final void Function() dismissSelf;

  const MessageOverlay(
      {Key? key,
      required this.dismissSelf,
      required this.link,
      required this.message})
      : super(key: key);

  @override
  _MessageOverlayState createState() => _MessageOverlayState();
}

class _MessageOverlayState extends State<MessageOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorAnimation;
  late Animation<double> _optionsRevealAnimation;

  double verticalOffset = 0.0;

  GlobalKey renderKey = GlobalKey();

  //estimation for first render; actual value set in
  //callback
  double topSectionHeight = 19.0;

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  void _prepareAnimations() {
    _animationController =
        AnimationController(vsync: this, duration: _ANIMATION_DURATION)
          ..addListener(_tickAnimation);

    _optionsRevealAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _colorAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.black.withAlpha(50))
            .animate(_animationController);
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
      CompositedTransformFollower(
        offset: Offset(0, -topSectionHeight - verticalOffset),
        link: widget.link,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SimpleMessageDisplay.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            key: renderKey,
            children: [
              SizeProvider(
                onChildSize: (size) {
                  setState(() {
                    topSectionHeight = size.height;
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(MessageOverlay.BORDER_RADIUS))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 12.0),
                    child: Text(
                      toDisplayDateTime(widget.message.createdAt),
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
              SimpleMessageDisplay(
                withPadding: false,
                message: widget.message,
              ),
              Container(
                height: MessageOverlay.BORDER_RADIUS,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(MessageOverlay.BORDER_RADIUS))),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: _optionsRevealAnimation,
                child: MessageOptions(
                  options: [
                    MessageOption(
                        icon: Icons.copy,
                        onClick: () {
                          ClipboardData data =
                              ClipboardData(text: widget.message.message);
                          Clipboard.setData(data).then((_) => context
                              .read<ToasterCubit>()
                              .add(Toast(
                                  message: 'Message Copied!',
                                  type: ToastType.Success)));
                          _leave();
                        },
                        text: 'Copy Message'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  void _leave() {
    _animationController.reverse().then((_) => widget.dismissSelf());
  }

  void _tickAnimation() {
    setState(() {
      verticalOffset += getSlidePosition();
    });
  }

  double getSlidePosition() {
    double offsetChange = 0;
    if (renderKey.currentContext != null) {
      final columnPosition = _getAbsolutePositionOfRenderKey();
      final safeArea = MediaQuery.of(context).padding;

      final highestPossiblePosition = safeArea.top + _EDGE_INSETS_PADDING;
      final lowestPossiblePosition = MediaQuery.of(context).size.height -
          safeArea.bottom -
          _EDGE_INSETS_PADDING;

      if (highestPossiblePosition > columnPosition.top) {
        offsetChange -= highestPossiblePosition - columnPosition.top;
      }

      if (columnPosition.bottom > lowestPossiblePosition) {
        offsetChange -= lowestPossiblePosition - columnPosition.bottom;
      }
    }
    return offsetChange;
  }

  //x is ignored; always 0. only gets y.
  Rect _getAbsolutePositionOfRenderKey() {
    assert(renderKey.currentContext != null);
    final RenderBox renderBox =
        renderKey.currentContext!.findRenderObject() as RenderBox;

    final dy = renderBox.localToGlobal(Offset.zero).dy;

    return Rect.fromLTWH(0, dy, 0, renderBox.size.height);
  }
}
