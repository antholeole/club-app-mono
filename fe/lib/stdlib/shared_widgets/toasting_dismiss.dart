import 'dart:async';

import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ToastingDismissable extends StatelessWidget {
  final Widget _child;
  final String _confirmDismissText;
  final String _actionText;
  final VoidCallback _onConfirm;

  const ToastingDismissable(
      {required Key key,
      required Widget child,
      required String confirmDismissText,
      required VoidCallback onConfirm,
      required String actionText})
      : _child = child,
        _confirmDismissText = confirmDismissText,
        _actionText = actionText,
        _onConfirm = onConfirm,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.remove, color: Colors.white),
      ),
      confirmDismiss: (_) {
        final Completer<bool> completer = Completer();

        context.read<ToasterCubit>().add(CompleterToast(
            completer: completer,
            message: _confirmDismissText,
            action: ToastAction(actionText: _actionText, action: _onConfirm),
            type: ToastType.Warning));

        return completer.future;
      },
      key: key!,
      child: _child,
    );
  }
}
