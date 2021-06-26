import 'package:flutter/material.dart';

//primary duty is to refresh build context.
class ScaffoldButton extends StatelessWidget {
  final IconData _icon;
  final void Function(BuildContext) _onPressed;

  const ScaffoldButton(
      {required IconData icon, required void Function(BuildContext) onPressed})
      : _onPressed = onPressed,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_icon),
      onPressed: () => _onPressed(context),
    );
  }
}
