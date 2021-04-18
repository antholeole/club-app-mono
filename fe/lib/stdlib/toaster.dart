import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster extends InheritedWidget {
  final BuildContext context;
  final _fToast = FToast();

  Toaster({Key? key, required this.context, required Widget child})
      : super(key: key, child: child) {
    _fToast.init(context);
  }

  void errorToast(String message,
      {void Function()? action, String? actionText}) {
    _toast(
        message,
        Icon(
          Icons.report,
          color: Colors.red,
          size: 36,
        ),
        Colors.red.shade50,
        action: action,
        actionColor: Colors.red.shade900,
        actionText: actionText);
  }

  void successToast(String message,
      {void Function()? action, String? actionText}) {
    _toast(
        message,
        Icon(
          Icons.done,
          color: Colors.green,
          size: 36,
        ),
        Colors.green.shade50,
        action: action,
        actionColor: Colors.green.shade900,
        actionText: actionText);
  }

  @override
  bool updateShouldNotify(Toaster old) => false;

  void warningToast(String message,
      {void Function()? action, String? actionText}) {
    _toast(
        message,
        Icon(
          Icons.warning_rounded,
          color: Colors.amber,
          size: 36,
        ),
        Colors.amber.shade50,
        action: action,
        actionColor: Colors.amber.shade900,
        actionText: actionText);
  }

  Widget _baseToast(Icon icon, Color iconBgColor, Widget inner) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2.5),
                blurRadius: 3,
                spreadRadius: 1.5,
                color: Colors.grey.shade200)
          ],
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: iconBgColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: inner,
              ),
            ),
            GestureDetector(
              onTap: () => _fToast.removeCustomToast(),
              child: Icon(
                Icons.close,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String message,
      {void Function()? action, String? actionText, Color? actionTextColor}) {
    // ignore: omit_local_variable_types
    List<Widget> children = [
      Text(
        message,
      ),
    ];

    if (action != null) {
      children.add(GestureDetector(
        onTap: action,
        child: Text(
          actionText!,
          style: TextStyle(color: actionTextColor),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  void _showToast(Widget toast) {
    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 200),
    );
  }

  void _toast(String message, Icon icon, Color behindIconColor,
      {void Function()? action, String? actionText, Color? actionColor}) {
    assert(
        (action == null && actionText == null) ||
            (action != null && actionText != null),
        'Toast must either have both action and actionText or neither');

    var inner;
    if (action != null) {
      inner = _buildMessage(message,
          action: action, actionText: actionText, actionTextColor: actionColor);
    } else {
      inner = _buildMessage(message);
    }

    _showToast(_baseToast(icon, behindIconColor, inner));
  }

  static Toaster of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Toaster>();
    assert(result != null, 'No Toaster found in context');
    return result!;
  }
}

enum ToastType { Info, Error, Success }
