import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  final String? _name;
  final List<Widget> _buttons;

  const ButtonGroup({String? name, required List<Widget> buttons})
      : _name = name,
        _buttons = buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TileHeader(
          text: _name,
        ),
        ..._buttons
      ],
    );
  }
}
