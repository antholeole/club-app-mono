import 'package:fe/data/models/thread.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/notification_container_listener.dart';
import 'package:flutter/material.dart';

class ChannelTile extends StatelessWidget {
  final bool _selected;
  final Thread _thread;
  final VoidCallback _onTap;
  final bool _viewOnly;
  final UuidType _currentGroupId;

  const ChannelTile(
      {Key? key,
      required bool selected,
      required Thread thread,
      required UuidType currentGroupId,
      required Function() onTap,
      required bool viewOnly})
      : _selected = selected,
        _thread = thread,
        _onTap = onTap,
        _viewOnly = viewOnly,
        _currentGroupId = currentGroupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = _viewOnly ? Colors.grey.shade500 : Colors.black;

    return NotificationContainerListener<int>(
      defaultValue: 0,
      path: ThreadNotificationPath(
          threadId: _thread.id, groupId: _currentGroupId),
      builder: (unreadMessages) => Container(
        decoration: BoxDecoration(
            color: _selected ? Colors.grey.shade200 : Colors.transparent,
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
            onTap: _onTap,
            title: Text(_thread.name,
                style: TextStyle(
                    color: textColor,
                    fontWeight: unreadMessages != 0
                        ? FontWeight.bold
                        : FontWeight.normal)),
            leading: Text('#',
                style: TextStyle(
                    fontSize: 28,
                    color: textColor,
                    fontWeight: unreadMessages > 0
                        ? FontWeight.bold
                        : FontWeight.normal)),
            trailing: (unreadMessages > 0)
                ? Chip(
                    backgroundColor: Colors.red,
                    label: Text(
                      unreadMessages.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : null),
      ),
    );
  }
}
