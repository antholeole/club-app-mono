import 'package:flutter/material.dart';
import 'dart:math';

class FlippableIcon extends StatefulWidget {
  static const FLIP_DURATION = Duration(milliseconds: 200);

  final Icon _icon;
  final void Function() _onClick;
  final bool flipped;

  const FlippableIcon(
      {required Icon icon,
      required void Function() onClick,
      required this.flipped})
      : _onClick = onClick,
        _icon = icon;

  @override
  _FlippableIconState createState() => _FlippableIconState();
}

class _FlippableIconState extends State<FlippableIcon>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FlippableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _flipWidget();
    super.didChangeDependencies();
  }

  void _prepareAnimations() {
    _controller =
        AnimationController(duration: FlippableIcon.FLIP_DURATION, vsync: this);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget._onClick(),
        child: Transform.rotate(
          angle: (90 * 3) * (pi / 180),
          child: RotationTransition(
            turns: _animation,
            child: widget._icon,
          ),
        ));
  }

  void _flipWidget() {
    if (widget.flipped) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
