import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class User {
  final String name;
  final String? profilePictureUrl;
  final UuidType id;

  const User({required this.name, this.profilePictureUrl, required this.id});

  factory User.fromJson(String jsonString) =>
      _$UserFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
