import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/services/toaster/toast_display.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/data_carriers/toast.dart';

class Toaster extends StatelessWidget {
  final Widget child;

  const Toaster({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToasterCubit(),
      child: ToasterDisplay(child: child),
    );
  }
}

class ToasterDisplay extends StatelessWidget {
  final Widget child;

  const ToasterDisplay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToasterCubit, ToasterState>(
      builder: (_, state) => Stack(
        children: [
          child,
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: _buildToasts(state.toasts),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToasts(List<Toast> toasts) {
    return DefaultTextStyle(
      style:
          const TextStyle(color: Colors.black, decoration: TextDecoration.none),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: toasts.reversed
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToastDisplay(toast: e),
                ))
            .toList(),
      ),
    );
  }
}
