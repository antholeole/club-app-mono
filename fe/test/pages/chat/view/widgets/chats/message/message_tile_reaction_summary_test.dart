import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/message_tile_reaction_summary.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../test_helpers/pump_app.dart';

void main() {
  final fakeUserOne = User(name: 'Luna Pants', id: UuidType.generate());
  final fakeUserTwo = User(name: 'Han Lo', id: UuidType.generate());

  testWidgets('should display nothing on no reactions', (tester) async {
    await tester.pumpApp(const MessageTileReactionSummary(reactions: {}));
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('should display all unique reaction types', (tester) async {
    final reactionTypes = [
      [ReactionType.Angry, ReactionType.Angry, ReactionType.Cry],
      [ReactionType.Angry, ReactionType.Wow, ReactionType.Laugh],
      [ReactionType.Like, ReactionType.Like, ReactionType.Laugh],
      [ReactionType.Wow],
      []
    ];

    for (int i = 0; i < reactionTypes.length; i++) {
      final uniques = reactionTypes[i].toSet();

      Reaction(
          id: UuidType.generate(),
          likedBy: fakeUserTwo,
          messageId: UuidType.generate(),
          type: ReactionType.Angry);
      await tester.pumpApp(MessageTileReactionSummary(
          reactions: uniques
              .map((e) => Reaction(
                  id: UuidType.generate(),
                  likedBy: fakeUserTwo,
                  messageId: UuidType.generate(),
                  type: e))
              .toSet()));

      for (ReactionType unique in uniques) {
        expect(find.text(unique.emoji), findsOneWidget);
      }
    }
  });

  testWidgets('should display one likers name on only one liker',
      (tester) async {
    await tester.pumpApp(MessageTileReactionSummary(reactions: {
      Reaction(
          id: UuidType.generate(),
          likedBy: fakeUserTwo,
          messageId: UuidType.generate(),
          type: ReactionType.Angry),
    }));

    expect(find.textContaining(fakeUserTwo.name), findsOneWidget);
  });

  testWidgets('should display liker name +n more on more than one liker',
      (tester) async {
    await tester.pumpApp(MessageTileReactionSummary(reactions: {
      Reaction(
          id: UuidType.generate(),
          likedBy: fakeUserTwo,
          messageId: UuidType.generate(),
          type: ReactionType.Angry),
      Reaction(
          id: UuidType.generate(),
          likedBy: fakeUserOne,
          messageId: UuidType.generate(),
          type: ReactionType.Angry),
    }));

    expect(find.textContaining('+1'), findsOneWidget);
  });
}
