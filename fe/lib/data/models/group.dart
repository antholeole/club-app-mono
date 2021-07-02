import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../stdlib/helpers/uuid_type.dart';

part 'group.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Group {
  final UuidType id;
  String name;
  bool admin;
  bool hasNotifications = false;

  Group({required this.id, required this.name, required this.admin});

  factory Group.fromJson(String jsonString) =>
      _$GroupFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
