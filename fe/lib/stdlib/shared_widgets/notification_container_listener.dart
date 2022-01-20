import 'package:fe/services/local_data/notification_container.dart';
import 'package:flutter/material.dart';
import '../../service_locator.dart';

class NotificationContainerListener<T> extends StatefulWidget {
  final T _defaultValue;
  final NotificationPath _path;
  final Widget Function(T) _builder;

  const NotificationContainerListener(
      {Key? key,
      required NotificationPath path,
      frozen = false,
      required T defaultValue,
      required Widget Function(T) builder})
      : _defaultValue = defaultValue,
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
    _value = _notificationContainer.get<T>(widget._path, widget._defaultValue);
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
    if (_value != maybeNew) {
      setState(() {
        _value = maybeNew;
      });
    }
  }
}
