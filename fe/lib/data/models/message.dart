import 'package:equatable/equatable.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

class Message extends Equatable {
  final User user;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isImage;
  final UuidType id;
  final List<Reaction> reactions;

  bool get updated => updatedAt != createdAt;

  const Message(
      {required this.user,
      required this.id,
      required this.message,
      List<Reaction>? reactions,
      required this.isImage,
      required this.createdAt,
      required this.updatedAt})
      : reactions = reactions ?? const [];

  @override
  List<Object?> get props => [id, reactions];
}
