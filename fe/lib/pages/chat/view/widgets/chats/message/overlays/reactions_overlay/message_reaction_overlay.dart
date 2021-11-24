import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/reaction_display.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessageReactionOverlay extends StatefulWidget {
  final LayerLink _link;
  final VoidCallback _dismissSelf;
  final ScrollController _scrollController;
  final Message _message;
  final UuidType _selfId;

  const MessageReactionOverlay(
      {Key? key,
      required LayerLink link,
      required Message message,
      required UuidType selfId,
      required VoidCallback dismissSelf,
      required ScrollController scrollController})
      : _link = link,
        _selfId = selfId,
        _scrollController = scrollController,
        _message = message,
        _dismissSelf = dismissSelf,
        super(key: key);

  @override
  _MessageReactionOverlayState createState() => _MessageReactionOverlayState();
}

class _MessageReactionOverlayState extends State<MessageReactionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appearController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _appearAnimation = CurvedAnimation(
    parent: _appearController,
    curve: Curves.easeIn,
  );

  final Map<ReactionType, int> reactionCounts =
      Map.fromEntries(ReactionType.values.map((e) => MapEntry(e, 0)));

  @override
  void initState() {
    widget._message.reactions.forEach((reaction) =>
        reactionCounts[reaction.type] = reactionCounts[reaction.type]! + 1);
    _appearController.addListener(() => setState(() {}));
    _appearController.forward();
    widget._scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _appearController.dispose();
    widget._scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: CompositedTransformFollower(
          link: widget._link,
          offset: Offset(
              screenWidth * 0.1, (widget._link.leaderSize?.height ?? 0) + 5),
          child: DefaultTextStyle(
            style: const TextStyle(
                decoration: TextDecoration.none, fontSize: 36.0),
            child: FadeTransition(
              opacity: _appearAnimation,
              child: SizedBox(
                width: screenWidth * 0.8,
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
    for (final existingReaction in widget._message.reactions) {
      if (existingReaction.type == reaction &&
          existingReaction.likedBy.id == widget._selfId) {
        return true;
      }
    }

    return false;
  }

  void _onScroll() {
    widget._dismissSelf();
  }
}
