import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../stdlib/helpers/uuid_type.dart';

part 'group.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Group extends Equatable {
  final UuidType id;
  final String name;
  final bool admin;

  const Group({required this.id, required this.name, required this.admin});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object?> get props => [id];
}
