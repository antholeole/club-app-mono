import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/schema.schema.gql.dart' show Gmessage_reaction_types_enum;

enum ReactionType { Like, Laugh, Wow, Cry, Angry }

class Reaction extends Equatable {
  final ReactionType type;
  final UuidType id;
  final UuidType likedBy;

  const Reaction({
    required this.type,
    required this.id,
    required this.likedBy,
  });

  @override
  List<Object?> get props => [type, id, likedBy];
}

extension ReactionEmoji on ReactionType {
  Gmessage_reaction_types_enum get gql {
    switch (this) {
      case ReactionType.Like:
        return Gmessage_reaction_types_enum.LIKE;
      case ReactionType.Angry:
        return Gmessage_reaction_types_enum.ANGRY;
      case ReactionType.Laugh:
        return Gmessage_reaction_types_enum.LAUGH;
      case ReactionType.Cry:
        return Gmessage_reaction_types_enum.CRY;
      case ReactionType.Wow:
        return Gmessage_reaction_types_enum.WOW;
    }
  }

  static ReactionType fromGql(Gmessage_reaction_types_enum gql) {
    switch (gql) {
      case Gmessage_reaction_types_enum.LIKE:
        return ReactionType.Like;
      case Gmessage_reaction_types_enum.ANGRY:
        return ReactionType.Angry;
      case Gmessage_reaction_types_enum.LAUGH:
        return ReactionType.Laugh;
      case Gmessage_reaction_types_enum.CRY:
        return ReactionType.Cry;
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
      case ReactionType.Cry:
        return '😭';
      case ReactionType.Laugh:
        return '😂';
      case ReactionType.Like:
        return '❤️';
      case ReactionType.Wow:
        return '😮';
    }
  }
}
