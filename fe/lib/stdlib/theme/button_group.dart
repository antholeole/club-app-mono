import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/material.dart';

class ButtonData {
  final void Function() onClick;
  final String text;
  final Color color;
  final bool loading;

  const ButtonData(
      {required this.text,
      this.color = Colors.grey,
      required this.onClick,
      this.loading = false});
}

class ButtonGroup extends StatelessWidget {
  final String? _name;
  final List<ButtonData> _buttons;

  const ButtonGroup({String? name, required List<ButtonData> buttons})
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
        ..._buildButtons()
      ],
    );
  }

  List<Widget> _buildButtons() {
    return _buttons
        .map((e) => Tile(
                child: TextButton(
              onPressed: e.loading ? () {} : e.onClick,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: e.loading
                    ? Loader(size: 12)
                    : Text(
                        e.text,
                        style: TextStyle(color: e.color),
                      ),
              ),
            )))
        .toList();
  }
}
