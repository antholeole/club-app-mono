import 'package:flutter/material.dart';

class ChannelTile extends StatelessWidget {
  final int _unreadMessages;
  final bool _selected;
  final String _title;
  final VoidCallback _onTap;
  final bool _viewOnly;

  const ChannelTile(
      {Key? key,
      required int unreadMessages,
      required bool selected,
      required String title,
      required Function() onTap,
      required bool viewOnly})
      : _unreadMessages = unreadMessages,
        _selected = selected,
        _title = title,
        _onTap = onTap,
        _viewOnly = viewOnly,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = _viewOnly ? Colors.grey.shade500 : Colors.black;

    return Container(
      decoration: BoxDecoration(
          color: _selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
          onTap: _onTap,
          title: Text(_title,
              style: TextStyle(
                  color: textColor,
                  fontWeight: _unreadMessages != 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          leading: Text('#',
              style: TextStyle(
                  fontSize: 28,
                  color: textColor,
                  fontWeight: _unreadMessages > 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          trailing: (_unreadMessages > 0)
              ? Chip(
                  backgroundColor: Colors.red,
                  label: Text(
                    _unreadMessages.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : null),
    );
  }
}
