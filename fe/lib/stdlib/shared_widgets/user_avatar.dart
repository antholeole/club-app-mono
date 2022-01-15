import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class Avatar extends StatefulWidget {
  late final String _initals;
  final double? _radius;
  final UuidType _id;
  final Uint8List? _imageOverride;
  final GUploadType _type;

  factory Avatar.user(
      {required User user, double? radius, Uint8List? imageOverride}) {
    return Avatar._(
      name: user.name,
      radius: radius,
      type: GUploadType.UserAvatar,
      imageOverride: imageOverride,
      id: user.id,
    );
  }

  factory Avatar.club(
      {required Club club, double? radius, Uint8List? imageOverride}) {
    return Avatar._(
      name: club.name,
      radius: radius,
      type: GUploadType.GroupAvatar,
      imageOverride: imageOverride,
      id: club.id,
    );
  }

  Avatar._(
      {required UuidType id,
      required String name,
      double? radius,
      required GUploadType type,
      Uint8List? imageOverride})
      : _imageOverride = imageOverride,
        _id = id,
        _type = type,
        _radius = radius {
    _initals = name.split(' ').map((e) {
      if (e.isNotEmpty) {
        return e[0];
      } else {
        return '';
      }
    }).join('');
  }

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final ImageClient _imageClient = getIt<ImageClient>();
  final _handler = getIt<Handler>();

  String? _url;

  @override
  void initState() {
    if (widget._imageOverride == null) {
      _url =
          _imageClient.getImageDownloadUrlFromCache(widget._id, widget._type);

      if (_url == null) {
        _beginUrlSet();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._imageOverride != null) {
      return _buildCircleAvatar(MemoryImage(widget._imageOverride!));
    }

    if (_url == null) {
      return _buildCircleAvatar(null);
    } else {
      return _buildCircleAvatar(CachedNetworkImageProvider(_url!));
    }
  }

  Widget _buildCircleAvatar(ImageProvider? image) {
    return CircleAvatar(
      maxRadius: widget._radius,
      minRadius: widget._radius,
      foregroundImage: image,
      child: Text(widget._initals,
          style: TextStyle(
              fontSize: widget._radius != null ? widget._radius! / 2 : null)),
    );
  }

  Future<void> _beginUrlSet() async {
    try {
      final url =
          await _imageClient.getImageDownloadUrl(widget._id, widget._type);

      if (mounted) {
        setState(() {
          _url = url;
        });
      }
    } on Exception catch (e) {
      _handler.handleFailure(_handler.exceptionToFailure(e), context,
          toast: false);
    }
  }
}
