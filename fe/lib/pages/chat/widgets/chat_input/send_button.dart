import 'package:fe/stdlib/shared_widgets/no_overflow_crossfade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final bool _isSendable;

  const SendButton({Key? key, required bool isSendable})
      : _isSendable = isSendable,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoOverflowCrossfade(
        secondChild: Container(),
        firstChild: Transform.scale(
          scale: 0.85,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.send),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
        duration: const Duration(milliseconds: 100),
        crossFadeState:
            _isSendable ? CrossFadeState.showFirst : CrossFadeState.showSecond);
  }
}
