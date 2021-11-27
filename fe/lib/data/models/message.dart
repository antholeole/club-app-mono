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
  final Set<Reaction> reactions;

  bool get updated => updatedAt != createdAt;

  const Message(
      {required this.user,
      required this.id,
      required this.message,
      Set<Reaction>? reactions,
      required this.isImage,
      required this.createdAt,
      required this.updatedAt})
      : reactions = reactions ?? const {};

  @override
  List<Object?> get props => [id, reactions];

  Message copyWithNewReaction(Reaction newReaction) {
    return Message(
        user: user,
        id: id,
        message: message,
        isImage: isImage,
        createdAt: createdAt,
        reactions: {...reactions, newReaction},
        updatedAt: updatedAt);
  }

  Message copyWithoutReaction(Reaction removedReaction) {
    final newReactions = Set.of(reactions.toList());
    newReactions.remove(removedReaction);

    return Message(
        user: user,
        id: id,
        message: message,
        isImage: isImage,
        createdAt: createdAt,
        reactions: newReactions,
        updatedAt: updatedAt);
  }
}
