import 'package:flutter/material.dart';

class BottomNavTab extends StatelessWidget {
  final void Function()? _onHeld;
  final void Function() _onClick;
  final IconData _icon;
  final bool _active;

  const BottomNavTab({
    Key? key,
    required IconData icon,
    bool active = false,
    required void Function() onClick,
    void Function()? onHeld,
  })  : _onHeld = onHeld,
        _onClick = onClick,
        _icon = icon,
        _active = active,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      onLongPress: _onHeld,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(
              _icon,
              size: 40,
              color: _active ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          Container(
            width: 35,
            height: 4,
            decoration: BoxDecoration(
                color: _active
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
