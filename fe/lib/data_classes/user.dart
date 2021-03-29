import 'dart:convert';

import 'package:fe/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'local_user.dart';

part 'user.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class User {
  final String name;
  final UuidType uuid;
  final LoginType loggedInWith;
  final String accessToken;
  final String? email;

  User(
      {required this.name,
      required this.uuid,
      this.email,
      required this.loggedInWith,
      required this.accessToken});

  factory User.fromJson(String jsonString) =>
      _$UserFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
