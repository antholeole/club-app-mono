import 'package:flutter/material.dart';

class CustomWideButton extends StatelessWidget {
  final String _text;
  final void Function() _onClick;

  const CustomWideButton(
      {required String text, required void Function() onClick})
      : _text = text,
        _onClick = onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: _onClick,
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(20)),
        child: Text(
          _text,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
