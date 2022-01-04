import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;

class CachedBucketImage extends StatefulWidget {
  final UuidType _sourceId;
  final GUploadType _uploadType;

  final Widget? _loader;
  final Uint8List? _imageOverride;
  final Widget Function(ImageProvider)? _builder;

  const CachedBucketImage(
      {Key? key,
      Widget? loader,
      required UuidType sourceId,
      Uint8List? imageOverride,
      Widget Function(ImageProvider)? builder,
      required GUploadType uploadType})
      : _loader = loader,
        _builder = builder,
        _imageOverride = imageOverride,
        _sourceId = sourceId,
        _uploadType = uploadType,
        super(key: key);

  @override
  State<CachedBucketImage> createState() => _CachedBucketImageState();
}

class _CachedBucketImageState extends State<CachedBucketImage> {
  final _imageClient = getIt<ImageClient>();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();

    if (widget._imageOverride != null) {
      return;
    }

    _imageUrl = _imageClient.getImageDownloadUrlFromCache(
        widget._sourceId, widget._uploadType);

    if (_imageUrl == null) {
      _imageClient
          .getImageDownloadUrl(widget._sourceId, widget._uploadType)
          .then((url) => mounted
              ? setState(() {
                  _imageUrl = url;
                })
              : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._imageOverride != null) {
      return Image(image: MemoryImage(widget._imageOverride!));
    }

    if (_imageUrl == null) {
      return widget._loader ?? const Loader();
    } else {
      return CachedNetworkImage(
        imageUrl: _imageUrl!,
        placeholder: (context, _) => const Loader(),
        imageBuilder: widget._builder != null
            ? (context, imageProvider) => widget._builder!(imageProvider)
            : null,
      );
    }
  }
}
