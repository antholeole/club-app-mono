import 'package:flutter/material.dart';

class SelectedTabIndicator extends StatelessWidget {
  final bool _selected;
  final double _height;

  const SelectedTabIndicator(
      {Key? key, required double height, required bool selected})
      : _height = height,
        _selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: _height,
      color: _selected ? Colors.redAccent.shade100 : Colors.transparent,
    );
  }
}
