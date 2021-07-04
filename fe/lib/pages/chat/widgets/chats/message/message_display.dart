import 'package:fe/data/models/message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final Message _message;
  final void Function(Message, LayerLink)? _onTapped;
  final LayerLink link = LayerLink();

  MessageDisplay(
      {required Message message, void Function(Message, LayerLink)? onTapped})
      : _message = message,
        _onTapped = onTapped;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: GestureDetector(
        onTap: () {
          if (_onTapped != null) {
            _onTapped!(_message, link);
          }
        },
        child: ListTile(
          leading: UserAvatar(
            name: _message.sender.name,
            profileUrl: _message.sender.profilePictureUrl,
          ),
          title: Text(_message.sender.name),
          tileColor: Colors.white,
          subtitle: Text(
            _message.message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
  }
}
