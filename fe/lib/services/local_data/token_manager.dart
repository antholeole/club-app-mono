import 'package:fe/constants.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';

import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/gql/refresh.req.gql.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'local_file_store.dart';
import 'local_user_service.dart';

class TokenManager {
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _localFileStore = getIt<LocalFileStore>();
  final _localUserService = getIt<LocalUserService>();
  final _unauthClient = getIt<UnauthGqlClient>();

  String? _tokenCache;

  Future<void> initalizeTokens(BackendAccessTokens backendAccessTokens) async {
    await _localFileStore.serialize(
        LocalStorageType.AccessTokens, backendAccessTokens.accessToken);
    await _secureStorage.write(
        key: REFRESH_TOKEN_KEY, value: backendAccessTokens.refreshToken);
    _tokenCache = backendAccessTokens.accessToken;
  }

  Future<String?> get _refreshToken =>
      _secureStorage.read(key: REFRESH_TOKEN_KEY);

  Future<void> delete() async {
    await _localFileStore.delete(LocalStorageType.AccessTokens);
    await _secureStorage.delete(key: REFRESH_TOKEN_KEY);
    _tokenCache = null;
  }

  Future<String?> read() async {
    if (_tokenCache != null) {
      return _tokenCache!;
    }

    final serializedToken =
        await _localFileStore.deserialize(LocalStorageType.AccessTokens);

    _tokenCache = serializedToken;

    return serializedToken;
  }

  /// returns true if the token is valid with some buffer time.
  /// required in siutations where there is no bounce back if the token
  /// is expired (i.e. WS connection)
  Future<bool> tokenIsValid() async {
    final token = await read();

    if (token == null) {
      return false;
    } else {
      return JwtDecoder.getRemainingTime(token).inSeconds > 10;
    }
  }

  Future<String> refresh() async {
    final refreshToken = await _refreshToken;

    UuidType userId = await _localUserService.getLoggedInUserId();

    if (refreshToken == null) {
      throw const Failure(status: FailureStatus.RefreshFail);
    }

    try {
      final resp = await _unauthClient.request(GRefreshReq((q) => q
        ..vars.userId = userId
        ..vars.refreshToken = refreshToken
        ..fetchPolicy = FetchPolicy.NetworkOnly));

      final token = resp.refreshAccessToken!.accessToken;

      await _writeAccessToken(token);
      return token;
    } on Failure catch (_) {
      throw const Failure(status: FailureStatus.RefreshFail);
    }
  }

  Future<void> _writeAccessToken(String accessToken) async {
    _tokenCache = accessToken;
    await _localFileStore.serialize(LocalStorageType.AccessTokens, accessToken);
  }
}
