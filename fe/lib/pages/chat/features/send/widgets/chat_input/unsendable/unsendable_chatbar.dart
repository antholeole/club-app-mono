import 'package:flutter/material.dart';

enum UnsendableReason { ViewOnly }

extension Reason on UnsendableReason {
  String get reason {
    switch (this) {
      case UnsendableReason.ViewOnly:
        return 'Thread is view only.';
    }
  }
}

class UnsendableChatbar extends StatelessWidget {
  final UnsendableReason _reason;

  const UnsendableChatbar({Key? key, required UnsendableReason reason})
      : _reason = reason,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _reason.reason,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
