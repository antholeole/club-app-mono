import 'package:fe/stdlib/shared_widgets/no_overflow_crossfade.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final bool _isSendable;
  final void Function() _onClick;

  const SendButton(
      {Key? key, required bool isSendable, required void Function() onClick})
      : _isSendable = isSendable,
        _onClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoOverflowCrossfade(
        firstChild: Transform.scale(
          scale: 0.85,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.send),
              color: Colors.white,
              onPressed: _isSendable ? _onClick : () {},
            ),
          ),
        ),
        secondChild: Container(),
        duration: const Duration(milliseconds: 100),
        crossFadeState:
            _isSendable ? CrossFadeState.showFirst : CrossFadeState.showSecond);
  }
}
