import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'local_user.dart';

part 'provider_access_token.g.dart';

@JsonSerializable()
class ProviderIdToken {
  final String idToken;
  final LoginType from;

  const ProviderIdToken({required this.from, required this.idToken});

  factory ProviderIdToken.fromJson(String jsonString) =>
      _$ProviderIdTokenFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ProviderIdTokenToJson(this);
}
