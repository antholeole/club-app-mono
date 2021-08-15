import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'data_carriers/toast.dart';

part 'toaster_state.dart';

class ToasterCubit extends Cubit<ToasterState> {
  Map<UuidType, Timer> timers = {};

  ToasterCubit() : super(ToasterState());

  void add(Toast toast) {
    final newState = ToasterState.fromOther(state)..add(toast);

    if (toast.expireAt != null) {
      timers[toast.id] = (Timer(toast.expireAt!.difference(DateTime.now()),
          () => _removeTimer(toast.id)));
    }

    emit(newState);
  }

  void remove(UuidType toastId) {
    final newState = ToasterState.fromOther(state)..remove(toastId);

    timers.remove(toastId);
    emit(newState);
  }

  @override
  Future<void> close() async {
    timers.forEach((_, value) => value.cancel());
    await super.close();
  }

  void _removeTimer(UuidType toastId) {
    remove(toastId);
  }
}
