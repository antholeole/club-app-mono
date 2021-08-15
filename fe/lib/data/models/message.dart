import 'package:equatable/equatable.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/datetime_type_converter.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
@CustomUuidConverter()
@CustomDateTimeConverter()
class Message extends Equatable {
  final User user;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isImage;
  final UuidType id;

  bool get updated => updatedAt != createdAt;

  const Message(
      {required this.user,
      required this.id,
      required this.message,
      required this.isImage,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [id];

  factory Message.fromJson(Map<String, dynamic> jsonString) =>
      _$MessageFromJson(jsonString);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
