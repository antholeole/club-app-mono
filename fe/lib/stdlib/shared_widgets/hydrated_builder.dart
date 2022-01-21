import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

class HydratedSetter<T> {
  final void Function(T?) set;

  HydratedSetter({
    required this.set,
  });
}

class HydratedBuilder<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) _onBuild;
  final Widget Function(BuildContext) _onEmpty;
  final void Function(T? oldVal, T? newVal)? _onUpdate;
  final String Function(T) _serialize;
  final T Function(String) _deserialize;
  final T? _initalValue;
  final String _cacheKey;

  const HydratedBuilder(String cacheKey,
      {Key? key,
      T? initalValue,
      void Function(T? oldVal, T? newVal)? onUpdate,
      required Widget Function(BuildContext, T) onBuild,
      required Widget Function(BuildContext) onEmpty,
      required String Function(T) serialize,
      required T Function(String) deserialize})
      : _onBuild = onBuild,
        _onEmpty = onEmpty,
        _cacheKey = cacheKey,
        _onUpdate = onUpdate,
        _serialize = serialize,
        _deserialize = deserialize,
        _initalValue = initalValue,
        super(key: key);

  @override
  _HydratedBuilderState<T> createState() => _HydratedBuilderState<T>();
}

class _HydratedBuilderState<T> extends State<HydratedBuilder<T>> {
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  T? _currentValue;

  @override
  void didUpdateWidget(covariant HydratedBuilder<T> oldWidget) {
    if (widget._cacheKey != oldWidget._cacheKey) {
      final fromCache = _sharedPreferences.getString(widget._cacheKey);
      _set(fromCache != null ? widget._deserialize(fromCache) : null);
    } else if (widget._initalValue != null &&
        widget._initalValue != _currentValue) {
      _set(widget._initalValue);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _currentValue = widget._initalValue;

    if (_currentValue == null) {
      final fromCache = _sharedPreferences.getString(widget._cacheKey);

      if (fromCache != null) {
        _currentValue = widget._deserialize(fromCache);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<HydratedSetter<T>>(
      create: (context) => HydratedSetter(set: _set),
      child: _currentValue == null
          ? widget._onEmpty(context)
          : Provider.value(
              value: _currentValue!,
              child: widget._onBuild(context, _currentValue!)),
    );
  }

  void _set(T? value) {
    widget._onUpdate?.call(_currentValue, value);
    if (value == null) {
      _sharedPreferences.remove(widget._cacheKey);
      setState(() {
        _currentValue = null;
      });
    } else {
      _sharedPreferences.setString(widget._cacheKey, widget._serialize(value));
      setState(() {
        _currentValue = value;
      });
    }
  }
}
