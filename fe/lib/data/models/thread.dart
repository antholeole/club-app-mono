import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Thread {
  final String name;
  final UuidType id;

  const Thread({required this.name, required this.id});

  factory Thread.fromJson(String jsonString) =>
      _$ThreadFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}
