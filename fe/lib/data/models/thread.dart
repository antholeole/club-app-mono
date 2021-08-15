import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class Thread extends Equatable {
  final String name;
  final UuidType id;

  const Thread({required this.name, required this.id});

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadToJson(this);

  @override
  List<Object?> get props => [name, id];
}
