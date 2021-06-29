import 'package:flutter/material.dart';

enum WsMessageType { Message }

extension DiscriminatorString on WsMessageType {
  String get type {
    switch (this) {
      case WsMessageType.Message:
        return 'Message';
    }
  }
}

abstract class WsMessage {
  const WsMessage();

  @protected
  Map<String, dynamic> selfToJson();

  WsMessageType get messageType;

  Map<String, dynamic> toJson() {
    return {...selfToJson(), 'type': messageType.type};
  }
}
