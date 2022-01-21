import 'package:fe/services/local_data/notification_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../service_locator.dart';

class NotificationContainerListener<T> extends StatefulWidget {
  final T _defaultValue;
  final NotificationPath _path;
  final Widget Function(T) _builder;

  const NotificationContainerListener(
      {Key? key,
      required NotificationPath path,
      required T defaultValue,
      required Widget Function(T) builder})
      : assert(defaultValue is Map || defaultValue is int),
        _defaultValue = defaultValue,
        _path = path,
        _builder = builder,
        super(key: key);

  @override
  _NotificationContainerListenerState<T> createState() =>
      _NotificationContainerListenerState<T>();
}

class _NotificationContainerListenerState<T>
    extends State<NotificationContainerListener<T>> {
  final _notificationContainer = getIt<NotificationContainer>();

  late T _value = widget._defaultValue;

  @override
  void initState() {
    _notificationContainer.addListener(_onNotificationChange);

    _value = _getDeepCopy(
        _notificationContainer.get<T>(widget._path, widget._defaultValue));

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
    final maybeNew =
        _notificationContainer.get<T>(widget._path, widget._defaultValue);

    bool equal;
    if (T is Map) {
      equal =
          const DeepCollectionEquality().equals(_value as Map, maybeNew as Map);
    } else {
      equal = _value == maybeNew;
    }

    if (!equal) {
      //issue: another widget in the tree is updating this (during it's build because we clicked on it, and thus)
      //we are trying to modify ourselves during the build
      SchedulerBinding.instance!.scheduleFrameCallback((_) {
        if (mounted) {
          setState(() {
            _value = _getDeepCopy(maybeNew);
          });
        }
      });
    }
  }

  T _getDeepCopy(T val) {
    if (T is Map) {
      return Map.from(val as Map) as T;
    } else {
      return val;
    }
  }
}
