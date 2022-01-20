import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/schema.schema.gql.dart' show Gmessage_reaction_types_enum;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction.freezed.dart';

enum ReactionType {
  @JsonValue('Heart')
  Heart,
  @JsonValue('Laugh')
  Laugh,
  @JsonValue('Wow')
  Wow,
  @JsonValue('Straight')
  Straight,
  @JsonValue('Angry')
  Angry
}

@freezed
class Reaction with _$Reaction {
  factory Reaction(
      {required ReactionType type,
      @CustomUuidConverter() required UuidType id,
      required User likedBy,
      @CustomUuidConverter() required UuidType messageId}) = _Reaction;
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
