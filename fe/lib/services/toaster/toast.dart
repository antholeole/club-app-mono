import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/data_carriers/toast.dart';
import 'cubit/toaster_cubit.dart';

class ToastDisplay extends StatefulWidget {
  final Toast toast;

  const ToastDisplay({
    Key? key,
    required this.toast,
  }) : super(key: key);

  @override
  _ToastDisplayState createState() => _ToastDisplayState();
}

class _ToastDisplayState extends State<ToastDisplay> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2.5),
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
                  BoxDecoration(shape: BoxShape.circle, color: _iconBgColor()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _getIcon(),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: _buildMessage()),
            ),
            GestureDetector(
              onTap: () => context.read<ToasterCubit>().remove(widget.toast.id),
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

  Widget _buildMessage() {
    final List<Widget> children = [
      Text(
        widget.toast.message,
      ),
    ];

    if (widget.toast.action != null) {
      children.add(GestureDetector(
        onTap: () {
          context.read<ToasterCubit>().remove(widget.toast.id);
          widget.toast.action!.action();
        },
        child: Text(
          widget.toast.action!.actionText,
          style: TextStyle(color: _actionColor()),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Color _actionColor() {
    switch (widget.toast.type) {
      case ToastType.Error:
        return Colors.red.shade900;
      case ToastType.Warning:
        return Colors.amber.shade900;
      case ToastType.Success:
        return Colors.green.shade900;
    }
  }

  Color _iconBgColor() {
    switch (widget.toast.type) {
      case ToastType.Success:
        return Colors.green.shade50;
      case ToastType.Error:
        return Colors.red.shade50;
      case ToastType.Warning:
        return Colors.amber.shade50;
    }
  }

  Icon _getIcon() {
    switch (widget.toast.type) {
      case ToastType.Warning:
        return const Icon(
          Icons.warning_rounded,
          color: Colors.amber,
          size: 36,
        );
      case ToastType.Success:
        return const Icon(
          Icons.done,
          color: Colors.green,
          size: 36,
        );
      case ToastType.Error:
        return const Icon(
          Icons.report,
          color: Colors.red,
          size: 36,
        );
    }
  }
}
