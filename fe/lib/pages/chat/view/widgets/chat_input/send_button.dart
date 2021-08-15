import 'package:fe/stdlib/shared_widgets/no_overflow_crossfade.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final bool _isSendable;
  final void Function() _onClick;
  final bool _loading;

  const SendButton(
      {Key? key,
      required bool loading,
      required bool isSendable,
      required void Function() onClick})
      : _isSendable = isSendable,
        _onClick = onClick,
        _loading = loading,
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
              padding: const EdgeInsets.all(0),
              icon: _loading
                  ? const Loader(size: 12, white: true)
                  : const Icon(Icons.send),
              color: Colors.white,
              onPressed: _onClick,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 100),
        crossFadeState:
            _isSendable ? CrossFadeState.showFirst : CrossFadeState.showSecond);
  }
}
