import 'package:fe/stdlib/shared_widgets/no_overflow_crossfade.dart';
import 'package:flutter/material.dart';

final Color _iconColor = Colors.grey.shade500;

class ChatButtons extends StatelessWidget {
  final bool _isOpen;
  final void Function() _manuallyShowButtons;

  const ChatButtons(
      {Key? key,
      required bool isOpen,
      required void Function() manuallyShowbuttons})
      : _isOpen = isOpen,
        _manuallyShowButtons = manuallyShowbuttons,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoOverflowCrossfade(
      firstChild: Row(children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ac_unit,
              color: _iconColor,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.photo,
              color: _iconColor,
            )),
      ]),
      secondChild: IconButton(
          onPressed: _manuallyShowButtons,
          icon: Icon(
            Icons.chevron_right_outlined,
            color: _iconColor,
          )),
      crossFadeState:
          _isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 100),
    );
  }
}
