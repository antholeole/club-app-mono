import 'package:fe/data/models/message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatefulWidget {
  final Message _message;
  final void Function(UuidType) _onTapped;
  final UuidType? _selectedMessageId;

  const MessageDisplay(
      {required Message message,
      required void Function(UuidType) onTapped,
      UuidType? selectedMessageId})
      : _message = message,
        _onTapped = onTapped,
        _selectedMessageId = selectedMessageId;

  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay>
    with TickerProviderStateMixin {
  late Animation<double> _fadeAnimation;
  late AnimationController _fadeController;

  late AnimationController _bottomBarController;
  late Animation<double> _bottomBarAnimation;

  final duration = Duration(milliseconds: 150);
  final completedFadeAnimationValue = 0.5;
  final beginFadeAnimationValue = 1.0;

  @override
  void initState() {
    _prepareAnimations();

    _determineAnimations(true);

    super.initState();
  }

  void _prepareAnimations() {
    _fadeController = AnimationController(duration: duration, vsync: this);
    _bottomBarController = AnimationController(duration: duration, vsync: this);

    _fadeAnimation = Tween<double>(
            begin: beginFadeAnimationValue, end: completedFadeAnimationValue)
        .animate(_fadeController)
          ..addListener(() {
            setState(() {});
          });

    _bottomBarAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bottomBarController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MessageDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _determineAnimations(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget._onTapped(widget._message.id),
      child: AnimatedOpacity(
        opacity: _fadeAnimation.value,
        duration: duration,
        child: Column(
          children: [
            ListTile(
              leading: UserAvatar(
                name: widget._message.sender.name,
                profileUrl: widget._message.sender.profilePictureUrl,
              ),
              title: Text(widget._message.sender.name),
              tileColor: Colors.white,
              subtitle: Text(
                widget._message.message,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizeTransition(
              sizeFactor: _bottomBarAnimation,
              child: Container(
                color: Colors.red,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _determineAnimations(bool instant) {
    final selected = widget._selectedMessageId == widget._message.id;
    final noneSelected = widget._selectedMessageId != null;

    //FADE
    //if there is a widget selected, it is not us,
    //and we haven't animated, fade away
    if (noneSelected && !selected && !_fadeAnimation.isCompleted) {
      instant ? _fadeController.value = 1 : _fadeController.forward();
      //otherwise, if we are animated, and there is no selected message
      //or the selected message isn't us, come back
    } else if (_fadeAnimation.isCompleted && (noneSelected || !selected)) {
      instant ? _fadeController.value = 0 : _fadeController.reverse();
    }
  }
}
