import 'package:flutter/material.dart';

class JoinGroupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Join Club',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
