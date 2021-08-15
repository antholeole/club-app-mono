import 'package:fe/data/models/message.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class SimpleMessageDisplay extends StatelessWidget {
  static const double padding = 8.0;

  final Message _message;
  final bool _withPadding;

  const SimpleMessageDisplay(
      {required Message message, bool withPadding = true, Key? key})
      : _message = message,
        _withPadding = withPadding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _withPadding ? padding : 0.0),
        child: ListTile(
          leading: UserAvatar(
            name: _message.user.name,
            profileUrl: _message.user.profilePictureUrl,
          ),
          title: Text(_message.user.name),
          subtitle: Text(
            _message.message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
  }
}
