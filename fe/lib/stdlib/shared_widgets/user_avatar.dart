import 'dart:typed_data';

import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class UserAvatar extends StatefulWidget {
  late final String _initals;
  final double? _radius;
  final User _user;
  final Uint8List? _imageOverride;

  UserAvatar({required User user, double? radius, Uint8List? imageOverride})
      : _user = user,
        _imageOverride = imageOverride,
        _radius = radius {
    _initals = _user.name.split(' ').map((e) {
      if (e.isNotEmpty) {
        return e[0];
      } else {
        return '';
      }
    }).join('');
  }

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  final _imageClient = getIt<ImageClient>();

  Uint8List? _pfp;

  @override
  void initState() {
    if (widget._imageOverride != null) {
      _pfp = widget._imageOverride;
    } else {
      _imageClient
          .downloadImage(widget._user.id, GUploadType.UserAvatar)
          .then((value) => setState(() {
                _pfp = value;
              }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        maxRadius: widget._radius,
        minRadius: widget._radius,
        foregroundImage: _pfp != null ? MemoryImage(_pfp!) : null,
        child: _pfp == null
            ? Text(
                widget._initals,
                style: TextStyle(
                    fontSize:
                        widget._radius != null ? widget._radius! / 2 : null),
              )
            : null);
  }
}
