import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class MessageTileReactionSummary extends StatelessWidget {
  final Set<Reaction> _reactions;

  const MessageTileReactionSummary({Key? key, required Set<Reaction> reactions})
      : _reactions = reactions,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_reactions.isEmpty) {
      return Container();
    }

    final Set<ReactionType> uniqueReactions =
        Set.from(_reactions.map((reaction) => reaction.type));

    final uniqueReactionStack = Stack(
      alignment: Alignment.centerLeft,
      children: uniqueReactions
          .mapIndexed((i, reaction) => Padding(
                padding: EdgeInsets.only(left: i * 12),
                child: Text(
                  reaction.emoji,
                  style: const TextStyle(fontSize: 16),
                ),
              ))
          .toList(),
    );

    final Set<User> uniqueLikers =
        Set.from(_reactions.map((reaction) => reaction.likedBy));

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          uniqueReactionStack,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '${uniqueLikers.first.name}${uniqueLikers.length > 1 ? " +${uniqueLikers.length - 1} others" : ""}',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
