import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget {
  final double _size;
  final bool _white;

  const Loader({double size = 32, bool white = false})
      : _size = size,
        _white = white;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingGrid(
      size: widget._size,
      color: widget._white ? Colors.white : Theme.of(context).primaryColor,
      controller: _animationController,
    );
  }

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  void _prepareAnimations() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
  }
}
