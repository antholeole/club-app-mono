import 'package:equatable/equatable.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/schema.schema.gql.dart' show Gmessage_reaction_types_enum;

enum ReactionType { Heart, Laugh, Wow, Straight, Angry }

class Reaction extends Equatable {
  final ReactionType type;
  final UuidType id;
  final User likedBy;
  final UuidType messageId;

  const Reaction(
      {required this.type,
      required this.id,
      required this.likedBy,
      required this.messageId});

  @override
  List<Object?> get props => [type, id, likedBy, messageId];
}

extension ReactionEmoji on ReactionType {
  Gmessage_reaction_types_enum get gql {
    switch (this) {
      case ReactionType.Heart:
        return Gmessage_reaction_types_enum.HEART;
      case ReactionType.Angry:
        return Gmessage_reaction_types_enum.ANGRY;
      case ReactionType.Laugh:
        return Gmessage_reaction_types_enum.LAUGH;
      case ReactionType.Straight:
        return Gmessage_reaction_types_enum.STRAIGHT;
      case ReactionType.Wow:
        return Gmessage_reaction_types_enum.WOW;
    }
  }

  static ReactionType fromGql(Gmessage_reaction_types_enum gql) {
    switch (gql) {
      case Gmessage_reaction_types_enum.HEART:
        return ReactionType.Heart;
      case Gmessage_reaction_types_enum.ANGRY:
        return ReactionType.Angry;
      case Gmessage_reaction_types_enum.LAUGH:
        return ReactionType.Laugh;
      case Gmessage_reaction_types_enum.STRAIGHT:
        return ReactionType.Straight;
      case Gmessage_reaction_types_enum.WOW:
        return ReactionType.Wow;
    }

    //builtValue has no way to force exhaustive switches.
    //Sad. If adding a reactionType, please remember to update
    //me.
    throw Exception('unknown reaction type :(');
  }

  String get emoji {
    switch (this) {
      case ReactionType.Angry:
        return '😡';
      case ReactionType.Heart:
        return '❤️';
      case ReactionType.Laugh:
        return '😂';
      case ReactionType.Straight:
        return '😐';
      case ReactionType.Wow:
        return '😮';
    }
  }
}
