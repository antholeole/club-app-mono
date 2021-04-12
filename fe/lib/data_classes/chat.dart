import 'dart:convert';

import 'package:fe/data_classes/chat_message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Chat {
  final UuidType id;
  final String name;
  final List<ChatMessage> chats;

  Chat({required this.id, required this.name, required this.chats});

  factory Chat.fromJson(String jsonString) =>
      _$ChatFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
