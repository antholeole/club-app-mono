import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum WsMessageType { Message, Connect, Ping }

extension DiscriminatorString on WsMessageType {
  String get type {
    switch (this) {
      case WsMessageType.Message:
        return 'Message';
      case WsMessageType.Connect:
        return 'Connected';
      case WsMessageType.Ping:
        return 'Ping';
    }
  }
}

abstract class WsMessage extends Equatable {
  const WsMessage();

  @protected
  Map<String, dynamic> selfToJson();

  WsMessageType get messageType;

  Map<String, dynamic> toJson() {
    return {...selfToJson(), 'type': messageType.type};
  }

  static WsMessageType determineMessage(Map<String, dynamic> json) {
    final String type = json['type'] as String;

    return WsMessageType.values
        .firstWhere((messageType) => type == messageType.type);
  }
}
