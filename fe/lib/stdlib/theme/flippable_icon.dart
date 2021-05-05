import 'package:flutter/material.dart';
import 'dart:math';

const FLIP_DURATION = Duration(milliseconds: 200);

class FlippableIcon extends StatefulWidget {
  final Icon icon;
  final void Function(bool) onClick;

  const FlippableIcon({required this.icon, required this.onClick});

  @override
  _FlippableIconState createState() => _FlippableIconState();
}

class _FlippableIconState extends State<FlippableIcon>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  late bool _isOpen = true;

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
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
        onTap: _toggleMenu,
        child: Transform.rotate(
          angle: (90 * 3) * (pi / 180),
          child: RotationTransition(
            turns: _animation,
            child: widget.icon,
          ),
        ));
  }

  void _toggleMenu() {
    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isOpen = !_isOpen;
    });

    widget.onClick(_isOpen);
  }
}
