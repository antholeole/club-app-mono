import 'dart:typed_data';

import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:fe/gql/get_image_upload_url.req.gql.dart';
import 'package:http/http.dart' as http;
import 'package:fe/schema.schema.gql.dart' show GUploadType;
import 'package:fe/gql/get_image_download_url.req.gql.dart';

import '../../service_locator.dart';

class _ImageData {
  final Uint8List image;
  final String? imageName;

  const _ImageData({required this.image, required this.imageName});
}

class ImageClient {
  final _gqlClient = getIt<AuthGqlClient>();
  final _httpClient = getIt<http.Client>();

  final Map<String, Uint8List?> _imageCache = {};
  final Map<String, Future<Uint8List?>> _currentlyFetching = {};

  Future<Uint8List?> downloadImage(
      UuidType sourceId, GUploadType uploadType) async {
    final cacheKey = _serializeCacheKey(sourceId, uploadType);

    final fromCache = _imageCache[cacheKey];
    if (fromCache != null) {
      return fromCache;
    }

    final currentlyFetching = _currentlyFetching[cacheKey];
    if (currentlyFetching != null) {
      return currentlyFetching;
    }

    _currentlyFetching[cacheKey] = _downloadImage(sourceId, uploadType);
    return _currentlyFetching[cacheKey]!;
  }

  Future<Uint8List?> _downloadImage(
      UuidType sourceId, GUploadType uploadType) async {
    final url = (await _gqlClient
            .request(GGetImageDownloadUrlReq((q) => q
              ..vars.sourceId = sourceId
              ..vars.uploadType = uploadType))
            .first)
        .get_signed_download_link!
        .downloadUrl;

    final bytes = url == null
        ? null
        : (await NetworkAssetBundle(Uri.parse(url)).load(url))
            .buffer
            .asUint8List();

    _addToCache(sourceId, uploadType, bytes);

    // ignore: unawaited_futures
    _currentlyFetching.remove(_serializeCacheKey(sourceId, uploadType));

    return bytes;
  }

  Future<_ImageData> sendImage(
      XFile image, UuidType sourceId, GUploadType uploadType) async {
    try {
      final fileLength = await image.length();

      final uploadVerification = (await _gqlClient
              .request(GGetImageUploadUrlReq((q) => q
                ..vars.fileSize = fileLength
                ..vars.sourceId = sourceId
                ..vars.contentType =
                    image.mimeType ?? lookupMimeType(image.path)
                ..vars.uploadType = uploadType))
              .first)
          .insert_image!;

      final bytes = await image.readAsBytes();

      await _httpClient.put(Uri.parse(uploadVerification.uploadUrl),
          body: bytes);

      _addToCache(sourceId, uploadType, bytes);

      return _ImageData(image: bytes, imageName: uploadVerification.imageName);
    } on Exception catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw Failure(
            status: FailureStatus.Unknown,
            customMessage: 'unable to upload image: ${e.toString()}');
      }
    }
  }

  void _addToCache(
      UuidType sourceId, GUploadType uploadType, Uint8List? image) {
    _imageCache[_serializeCacheKey(sourceId, uploadType)] = image;
  }

  String _serializeCacheKey(UuidType sourceId, GUploadType uploadType) =>
      '${sourceId.uuid}+${uploadType.name}';
}
