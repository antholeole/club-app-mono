import 'package:fe/constants.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/json/refresh_carrier.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/http_client/http_client.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';

import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_file_store.dart';
import 'local_user_service.dart';

class TokenManager {
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _localFileStore = getIt<LocalFileStore>();
  final _unauthClient = getIt<UnauthHttpClient>();
  final _localUserService = getIt<LocalUserService>();
  bool hasTokens = false;

  String? _tokenCache;

  static Future<void> setTokens(BackendAccessTokens backendAccessTokens) async {
    await getIt<LocalFileStore>().serialize(
        LocalStorageType.AccessTokens, backendAccessTokens.accessToken);
    await getIt<FlutterSecureStorage>()
        .write(key: REFRESH_TOKEN_KEY, value: backendAccessTokens.refreshToken);
  }

  Future<void> initalizeTokens(BackendAccessTokens backendAccessTokens) async {
    await setTokens(backendAccessTokens);
    _tokenCache = backendAccessTokens.accessToken;
    hasTokens = true;
  }

  Future<String?> get _refreshToken =>
      _secureStorage.read(key: REFRESH_TOKEN_KEY);

  Future<void> delete() async {
    hasTokens = false;
    await _localFileStore.delete(LocalStorageType.AccessTokens);
    _tokenCache = null;
  }

  Future<String?> read() async {
    hasTokens = true;
    if (_tokenCache != null) {
      return _tokenCache!;
    }

    final serializedToken =
        await _localFileStore.deserialize(LocalStorageType.AccessTokens);

    return serializedToken;
  }

  Future<void> write(String token) async {
    _tokenCache = token;
    await _localFileStore.serialize(LocalStorageType.AccessTokens, token);
  }

  Future<String> refresh() async {
    hasTokens = true;
    final refreshToken = await _refreshToken;

    UuidType userId = await _localUserService.getLoggedInUserId();

    if (refreshToken == null) {
      throw const Failure(status: FailureStatus.RefreshFail);
    }

    try {
      final resp = await _unauthClient.postReq('/auth/refresh',
          RefreshCarrier(refreshToken: refreshToken, userId: userId).toJson());
      await _localFileStore.serialize(LocalStorageType.AccessTokens, resp.body);
      return resp.body;
    } on HttpException catch (e) {
      if (e.statusCode == 404) {
        //user not found
        throw const Failure(status: FailureStatus.RefreshFail);
      } else {
        rethrow;
      }
    }
  }
}
