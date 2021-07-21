import 'package:flutter/material.dart';

import 'message_overlay.dart';

class MessageOption {
  final IconData icon;
  final String text;
  final void Function() onClick;

  const MessageOption(
      {required this.icon, required this.text, required this.onClick});
}

class MessageOptions extends StatelessWidget {
  final List<MessageOption> _options;

  const MessageOptions({Key? key, required List<MessageOption> options})
      : _options = options,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> tiles = [];
    for (int i = 0; i < _options.length; i++) {
      late BorderRadiusGeometry borderRadius;

      if (i == 0 && i == _options.length - 1) {
        borderRadius = const BorderRadius.all(
            Radius.circular(MessageOverlay.BORDER_RADIUS));
      } else if (i == 0) {
        borderRadius = const BorderRadius.vertical(
            top: Radius.circular(MessageOverlay.BORDER_RADIUS));
      } else if (i == _options.length - 1) {
        borderRadius = const BorderRadius.vertical(
            bottom: Radius.circular(MessageOverlay.BORDER_RADIUS));
      } else {
        borderRadius = BorderRadius.zero;
      }

      tiles.add(GestureDetector(
        onTap: _options[i].onClick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(
                  _options[i].icon,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(_options[i].text),
                )
              ],
            ),
          ),
        ),
      ));

      if (i != _options.length - 1) {
        tiles.add(Container(
          color: Colors.grey.shade600,
          height: 0.3,
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: tiles,
      ),
    );
  }
}
