import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../service_locator.dart';

class NotificationContainerListener extends StatefulWidget {
  final NotificationPath _path;
  final Widget Function(List<UuidType>?) _builder;

  const NotificationContainerListener(
      {Key? key,
      required NotificationPath path,
      required Widget Function(List<UuidType>?) builder})
      : _path = path,
        _builder = builder,
        super(key: key);

  @override
  _NotificationContainerListenerState createState() =>
      _NotificationContainerListenerState();
}

class _NotificationContainerListenerState
    extends State<NotificationContainerListener> {
  final _notificationContainer = getIt<NotificationContainer>();

  List<UuidType>? _value;

  @override
  void initState() {
    _notificationContainer.addListener(_onNotificationChange);

    _value = _notificationContainer.get(widget._path);

    super.initState();
  }

  @override
  void dispose() {
    _notificationContainer.removeListener(_onNotificationChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_value);
  }

  void _onNotificationChange() {
    final maybeNew = _notificationContainer.get(widget._path);

    if (!const DeepCollectionEquality().equals(_value, maybeNew)) {
      //issue: another widget in the tree is updating this (during it's build because we clicked on it, and thus)
      //we are trying to modify ourselves during the build
      SchedulerBinding.instance!.scheduleFrameCallback((_) {
        if (mounted) {
          setState(() {
            _value = maybeNew == null ? null : List.from(maybeNew);
          });
        }
      });
    }
  }
}
