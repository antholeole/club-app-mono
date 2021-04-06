import 'package:flutter/material.dart';
import 'dart:math';

class DrawerGroup extends StatefulWidget {
  final String _name;

  DrawerGroup({required String name}) : _name = name;

  @override
  _DrawerGroupState createState() => _DrawerGroupState();
}

class _DrawerGroupState extends State<DrawerGroup>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  bool _isOpen = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget._name),
            GestureDetector(
                onTap: _toggleMenu,
                child: Transform.rotate(
                  angle: 90 * (pi / 180),
                  child: RotationTransition(
                    turns: _animation,
                    child: Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
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
  }
}
