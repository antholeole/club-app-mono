import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:sealed_unions/implementations/union_3_impl.dart';

part 'message_overlay_state.dart';

class MessageOverlayCubit extends Cubit<MessageOverlayState> {
  ScrollController scrollController;

  MessageOverlayCubit({required this.scrollController})
      : super(MessageOverlayState.none());

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  void dismissOverlay() {
    emit(MessageOverlayState.none());
  }

  void addSettingsOverlay(
      {required LayerLink layerLink, required Message message}) {
    emit(MessageOverlayState.settings(layerLink: layerLink, message: message));
  }

  void addReactionOverlay({
    required LayerLink layerLink,
    required Message message,
  }) {
    emit(MessageOverlayState.reactions(layerLink: layerLink, message: message));
  }
}
