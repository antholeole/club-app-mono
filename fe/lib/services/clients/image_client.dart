import 'dart:typed_data';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:fe/gql/get_image_upload_url.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show GUploadType;
import 'package:fe/gql/get_image_download_url.req.gql.dart';
import 'package:http/http.dart' as http;

import '../../service_locator.dart';

class _ImageData {
  final Uint8List image;
  final String? imageName;

  const _ImageData({required this.image, required this.imageName});
}

class ImageClient {
  final _gqlClient = getIt<AuthGqlClient>();
  final _httpClient = getIt<http.Client>();

  final Map<String, String?> _imageCache = {};
  final Map<String, Future<String?>> _fetching = {};

  String? getImageDownloadUrlFromCache(
      UuidType sourceId, GUploadType uploadType) {
    return _imageCache[_serializeCacheKey(sourceId, uploadType)];
  }

  Future<String?> getImageDownloadUrl(
      UuidType sourceId, GUploadType uploadType) async {
    var future = _fetching[_serializeCacheKey(sourceId, uploadType)];

    if (future != null) {
      return future;
    }

    future = _gqlClient
        .request(GGetImageDownloadUrlReq((q) => q
          ..vars.sourceId = sourceId
          ..vars.uploadType = uploadType))
        .first
        .then((value) {
      final url = value.get_signed_download_link?.downloadUrl;
      _imageCache[_serializeCacheKey(sourceId, uploadType)] = url;
      _fetching.remove(_serializeCacheKey(sourceId, uploadType));

      return url;
    });

    _fetching[_serializeCacheKey(sourceId, uploadType)] = future;

    return future;
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

      _imageCache[_serializeCacheKey(sourceId, uploadType)] =
          uploadVerification.uploadUrl;

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

  String _serializeCacheKey(UuidType sourceId, GUploadType uploadType) =>
      '${sourceId.uuid}+${uploadType.name}';
}
