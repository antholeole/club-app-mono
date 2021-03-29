import 'package:fe/data_classes/local_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'provider_access_token.g.dart';

@JsonSerializable()
class ProviderIdToken {
  final String idToken;
  final LoginType from;
  final String? email;
  final String? name;

  const ProviderIdToken(
      {required this.from, required this.idToken, this.name, this.email});

  factory ProviderIdToken.fromJson(String jsonString) =>
      _$ProviderIdTokenFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ProviderIdTokenToJson(this);
}
