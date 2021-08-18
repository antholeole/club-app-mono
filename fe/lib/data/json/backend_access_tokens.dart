import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backend_access_tokens.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class BackendAccessTokens {
  final String accessToken;
  final String refreshToken;
  final UuidType id;
  final String name;

  BackendAccessTokens(
      {required this.accessToken,
      required this.refreshToken,
      required this.name,
      required this.id});

  factory BackendAccessTokens.fromJson(String jsonString) =>
      _$BackendAccessTokensFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$BackendAccessTokensToJson(this);
}
