import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'message_message.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class WsMessageMessage extends WsMessage {
  final String message;
  final UuidType toId;

  @override
  WsMessageType get messageType => WsMessageType.Message;

  const WsMessageMessage({required this.message, required this.toId});

  factory WsMessageMessage.fromJson(String jsonString) =>
      _$WsMessageMessageFromJson(json.decode(jsonString));

  @override
  Map<String, dynamic> selfToJson() => _$WsMessageMessageToJson(this);
}
