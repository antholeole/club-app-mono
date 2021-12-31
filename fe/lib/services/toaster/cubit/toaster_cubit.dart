import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/foundation.dart';
import 'data_carriers/toast.dart';

part 'toaster_state.dart';

class ToasterCubit extends Cubit<ToasterState> {
  static const PROMPT_DURATION = Duration(seconds: 5);

  final Map<UuidType, Timer> _timers = {};

  ToasterCubit() : super(ToasterState());

  void add(Toast toast) {
    final newState = ToasterState.fromOther(state)..add(toast);

    if (toast.expireAt != null) {
      _timers[toast.id] = (Timer(
          toast.expireAt!.difference(DateTime.now()), () => remove(toast.id)));
    }

    emit(newState);
  }

  void remove(UuidType toastId) {
    final newState = ToasterState.fromOther(state);
    final removedToast = newState.remove(toastId);

    if (removedToast?.onDismiss != null) {
      removedToast!.onDismiss!();
    }

    _timers.remove(toastId);
    emit(newState);
  }

  @override
  Future<void> close() async {
    _timers.forEach((_, value) => value.cancel());
    await super.close();
  }
}
