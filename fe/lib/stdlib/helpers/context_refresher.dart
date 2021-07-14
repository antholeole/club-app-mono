import 'package:flutter/widgets.dart';

class ContextRefresher extends StatelessWidget {
  final Widget _child;
  final void Function(BuildContext)? _innerContextCallback;

  const ContextRefresher(
      {Key? key,
      required Widget child,
      void Function(BuildContext)? innerContextCallback})
      : _child = child,
        _innerContextCallback = innerContextCallback,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innerContext) {
        if (_innerContextCallback != null) {
          _innerContextCallback!(innerContext);
        }
        return _child;
      },
    );
  }
}
