import 'package:flutter/material.dart';

class OptionPill extends StatelessWidget {
  final int _total;
  final int _current;

  const OptionPill({required int total, required int current})
      : _total = total,
        _current = current,
        assert(current >= 0),
        assert(current < total);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('hi'),
      ),
    );
  }
}
