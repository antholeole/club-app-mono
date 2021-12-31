import 'package:fe/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_overlay_state.freezed.dart';

@freezed
class MessageOverlayState with _$MessageOverlayState {
  factory MessageOverlayState.none() = _None;
  factory MessageOverlayState.settings(LayerLink link, Message message) =
      _Settings;

  factory MessageOverlayState.reactions(LayerLink link, Message message) =
      _Reactions;
}
