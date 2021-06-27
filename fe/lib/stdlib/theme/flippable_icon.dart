import 'package:flutter/material.dart';
import 'dart:math';

const FLIP_DURATION = Duration(milliseconds: 200);

class FlippableIcon extends StatefulWidget {
  final Icon _icon;
  final void Function() _onClick;
  final bool _flipped;

  const FlippableIcon(
      {required Icon icon,
      required void Function() onClick,
      required bool flipped})
      : _flipped = flipped,
        _onClick = onClick,
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
  void didUpdateWidget(FlippableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _toggleMenu();
    super.didChangeDependencies();
  }

  void _prepareAnimations() {
    _controller = AnimationController(duration: FLIP_DURATION, vsync: this);

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

  void _toggleMenu() {
    if (widget._flipped) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
