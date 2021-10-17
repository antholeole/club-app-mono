import 'package:flutter/material.dart';

class SelectedTabIndicator extends StatelessWidget {
  @visibleForTesting
  final bool selected;
  final double _height;

  const SelectedTabIndicator(
      {Key? key, required double height, required this.selected})
      : _height = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: _height,
      color: selected ? Colors.redAccent.shade100 : Colors.transparent,
    );
  }
}
