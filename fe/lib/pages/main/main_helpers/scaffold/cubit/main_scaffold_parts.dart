import 'package:flutter/material.dart';

class ActionButton {
  final IconData icon;
  final void Function() onClick;

  const ActionButton({required this.icon, required this.onClick});
}

class MainScaffoldParts {
  final Widget? titleBarWidget;
  final List<ActionButton> actionButtons;
  final Widget? endDrawer;

  const MainScaffoldParts(
      {this.titleBarWidget, this.actionButtons = const [], this.endDrawer});
}
