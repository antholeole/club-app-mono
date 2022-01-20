import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/view/widgets/message_display.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'message_options.dart';

const int _EDGE_INSETS_PADDING = 20;

class MessageOptionsOverlay extends StatefulWidget {
  static const BORDER_RADIUS = 8.0;
  final LayerLink link;
  final Message message;
  final AnimationController _animationController;

  final void Function() dismissSelf;

  const MessageOptionsOverlay(
      {Key? key,
      required this.dismissSelf,
      required AnimationController animationController,
      required this.link,
      required this.message})
      : _animationController = animationController,
        super(key: key);

  @override
  _MessageOptionsOverlayState createState() => _MessageOptionsOverlayState();
}

class _MessageOptionsOverlayState extends State<MessageOptionsOverlay> {
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
    widget._animationController.addListener(_tickAnimation);

    _optionsRevealAnimation =
        Tween(begin: 0.0, end: 1.0).animate(widget._animationController);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
        offset: Offset(0, -topSectionHeight - verticalOffset),
        link: widget.link,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MessageDisplay.padding),
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
                            top: Radius.circular(
                                MessageOptionsOverlay.BORDER_RADIUS))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 12.0),
                      child: Text(
                        DateFormat("EEE, MMM d 'a't h:mm a")
                            .format(widget.message.createdAt),
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                MessageDisplay(
                  withPadding: false,
                  message: widget.message,
                ),
                Container(
                  height: MessageOptionsOverlay.BORDER_RADIUS,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                              MessageOptionsOverlay.BORDER_RADIUS))),
                ),
                SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: _optionsRevealAnimation,
                  child: MessageOptions(
                    options: [
                      MessageOption(
                          icon: Icons.copy,
                          onClick: () {
                            ClipboardData data = ClipboardData(
                                text: widget.message.maybeMap(
                                    text: (text) => text.text,
                                    orElse: () => ''));
                            Clipboard.setData(data).then((_) => context
                                .read<ToasterCubit>()
                                .add(Toast(
                                    message: 'Message Copied!',
                                    type: ToastType.Success)));
                          },
                          text: 'Copy Message'),
                    ],
                  ),
                ),
              ],
            )));
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
