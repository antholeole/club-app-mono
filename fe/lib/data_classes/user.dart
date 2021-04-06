import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'local_user.dart';

part 'user.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class User {
  final String name;
  final String pfpUrl;
  final UuidType uuid;

  User({required this.name, required this.uuid, required this.pfpUrl});

  factory User.fromJson(String jsonString) =>
      _$UserFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
