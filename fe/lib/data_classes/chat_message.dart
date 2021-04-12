import 'dart:convert';

import 'package:fe/data_classes/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

enum MessageType { Chat, Image }

abstract class Message {
  User from;
  MessageType messageType;

  Message({required this.from, required this.messageType});
}

class ImageMessage extends Message {
  Uri message;

  ImageMessage(
      {required User from,
      required MessageType messageType,
      required this.message})
      : super(from: from, messageType: messageType);
}

@JsonSerializable()
@CustomUuidConverter()
class ChatMessage extends Message {
  String message;
  UuidType sender;
  UuidType id;

  ChatMessage(
      {required User from,
      required MessageType messageType,
      required this.id,
      required this.sender,
      required this.message})
      : super(from: from, messageType: messageType);

  factory ChatMessage.fromJson(String jsonString) =>
      _$ChatMessageFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
