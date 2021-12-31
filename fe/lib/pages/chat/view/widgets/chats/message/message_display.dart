import 'package:fe/data/models/message.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/message_tile_reaction_summary.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  static const SELF_SENT_COLOR = Color(0xffE5F0F6);
  static const EMOJI_OFFSET = 15;

  static const double padding = 8.0;

  final Message _message;
  final bool _withPadding;
  final Color _color;

  const MessageDisplay(
      {required Message message,
      bool withPadding = true,
      Key? key,
      bool sentBySelf = false})
      : _message = message,
        _withPadding = withPadding,
        _color = sentBySelf ? const Color(0xffE5F0F6) : Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: Padding(
        padding: EdgeInsets.only(
            left: _withPadding ? MessageDisplay.padding : 0.0,
            right: _withPadding ? MessageDisplay.padding : 0.0,
            bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              minVerticalPadding: 0,
              leading: UserAvatar(
                name: _message.user.name,
                profileUrl: _message.user.profilePictureUrl,
              ),
              title: Text(_message.user.name),
              subtitle: Text(
                _message.maybeMap(
                    text: (p0) => p0.text, orElse: () => 'IM AN IMAGE'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: MessageTileReactionSummary(
                  reactions: _message.reactions.values.toSet()),
            )
          ],
        ),
      ),
    );
  }
}
