import 'dart:convert';

import 'package:fe/data_classes/chat.dart';
import 'package:fe/data_classes/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Group {
  UuidType id;
  String name;
  List<User> members;
  List<Chat> chats;

  Group(
      {required this.id,
      required this.name,
      required this.members,
      required this.chats});

  factory Group.fromJson(String jsonString) =>
      _$GroupFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
