import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  late final String _initals;
  final String? _profileUrl;

  UserAvatar({required String name, String? profileUrl})
      : _profileUrl = profileUrl {
    _initals = name.split(' ').map((e) {
      if (e.isNotEmpty) {
        return e[0];
      } else {
        return '';
      }
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: _profileUrl != null ? NetworkImage(_profileUrl!) : null,
      child: _profileUrl == null ? Text(_initals) : null,
    );
  }
}
