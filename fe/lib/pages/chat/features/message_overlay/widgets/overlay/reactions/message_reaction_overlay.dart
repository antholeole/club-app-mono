import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/pages/chat/features/message_overlay/widgets/overlay/reactions/reaction_display.dart';
import 'package:fe/pages/chat/view/widgets/message_display.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';

class MessageReactionOverlay extends StatefulWidget {
  final AnimationController _animationController;

  final LayerLink _link;
  final VoidCallback _dismissSelf;

  final Message _message;
  final UuidType _selfId;

  const MessageReactionOverlay(
      {Key? key,
      required LayerLink link,
      required Message message,
      required AnimationController animationController,
      required UuidType selfId,
      required VoidCallback dismissSelf})
      : _link = link,
        _selfId = selfId,
        _animationController = animationController,
        _message = message,
        _dismissSelf = dismissSelf,
        super(key: key);

  @override
  _MessageReactionOverlayState createState() => _MessageReactionOverlayState();
}

class _MessageReactionOverlayState extends State<MessageReactionOverlay>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _appearAnimation = CurvedAnimation(
    parent: widget._animationController,
    curve: Curves.easeIn,
  );

  final Map<ReactionType, int> reactionCounts =
      Map.fromEntries(ReactionType.values.map((e) => MapEntry(e, 0)));

  @override
  void initState() {
    widget._message.reactions.values.forEach((reaction) =>
        reactionCounts[reaction.type] = reactionCounts[reaction.type]! + 1);
    widget._animationController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CompositedTransformFollower(
          link: widget._link,
          followerAnchor: Alignment.topLeft,
          offset: Offset(0, -(widget._link.leaderSize?.height ?? 0) - 30),
          child: DefaultTextStyle(
            style: const TextStyle(
                decoration: TextDecoration.none, fontSize: 36.0),
            child: FadeTransition(
              opacity: _appearAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MessageDisplay.padding),
                child: PhysicalModel(
                  elevation: _appearAnimation.value,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ReactionType.values
                          .map(
                            (reactionType) => ReactionDisplay(
                                reactionType: reactionType,
                                messageId: widget._message.id,
                                reactionCount: reactionCounts[reactionType]!,
                                onReacted: (_, __) => widget._dismissSelf(),
                                selfReacted: _getReacted(reactionType)),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  bool _getReacted(ReactionType reaction) {
    for (final existingReaction in widget._message.reactions.values) {
      if (existingReaction.type == reaction &&
          existingReaction.likedBy.id == widget._selfId) {
        return true;
      }
    }

    return false;
  }
}
