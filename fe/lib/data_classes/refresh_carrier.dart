import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_carrier.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class RefreshCarrier {
  final String refreshToken;
  final UuidType userId;

  RefreshCarrier({required this.refreshToken, required this.userId});

  factory RefreshCarrier.fromJson(String jsonString) =>
      _$RefreshCarrierFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$RefreshCarrierToJson(this);
}
