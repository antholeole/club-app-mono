import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../../service_locator.dart';

/// because when a thread is open, we don't want to say that there's new messages,
/// we should FREEZE the notification container.
/// It also matters that we unfreeze the old container.
class NotificationFreezer extends StatefulWidget {
  final Widget _child;

  const NotificationFreezer({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  _NotificationFreezerState createState() => _NotificationFreezerState();
}

class _NotificationFreezerState extends State<NotificationFreezer> {
  final _notificationContainer = getIt<NotificationContainer>();

  NotificationPath? _currentlyFrozen;

  @override
  void didChangeDependencies() {
    _updateFrozen(context.read<Thread>(), context.read<Group>());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //add thread and group to dependencies, so that
    //didChangeDepencencies is called when these are updated
    context.watch<Thread>();
    context.watch<Group>();

    return widget._child;
  }

  @override
  void dispose() {
    _unfreezeCurrent();
    super.dispose();
  }

  void _updateFrozen(Thread thread, Group group) {
    _unfreezeCurrent();
    group.map(
        dm: (dm) => _currentlyFrozen = DmNotificationPath(dmId: dm.id),
        club: (club) => _currentlyFrozen =
            ThreadNotificationPath(groupId: club.id, threadId: thread.id));
    _notificationContainer.clear(_currentlyFrozen!);
    _notificationContainer.freeze(_currentlyFrozen!);
  }

  void _unfreezeCurrent() {
    if (_currentlyFrozen != null) {
      _notificationContainer.unfreeze(_currentlyFrozen!);
      _currentlyFrozen = null;
    }
  }
}
