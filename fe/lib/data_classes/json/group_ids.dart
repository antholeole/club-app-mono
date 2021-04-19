import 'dart:convert';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_ids.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class GroupIds {
  List<UuidType> groupIds;

  GroupIds({required this.groupIds});

  factory GroupIds.fromJson(String jsonString) =>
      _$GroupIdsFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$GroupIdsToJson(this);
}
