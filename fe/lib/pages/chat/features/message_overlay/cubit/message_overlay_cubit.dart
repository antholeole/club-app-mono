import 'package:bloc/bloc.dart';
import 'package:fe/data/models/message.dart';
import 'package:flutter/material.dart';

import 'message_overlay_state.dart';

class MessageOverlayCubit extends Cubit<MessageOverlayState> {
  MessageOverlayCubit() : super(MessageOverlayState.none());

  @override
  Future<void> close() {
    return super.close();
  }

  void dismissOverlay() {
    emit(MessageOverlayState.none());
  }

  void addOverlay({
    required LayerLink layerLink,
    required Message message,
  }) {
    final maybeMessage =
        state.when(none: () => null, toggled: (_, message) => message);

    if (maybeMessage == message) {
      emit(MessageOverlayState.none());
    } else {
      emit(MessageOverlayState.toggled(layerLink, message));
    }
  }
}
