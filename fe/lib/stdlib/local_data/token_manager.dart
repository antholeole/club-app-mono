import 'package:fe/constants.dart';
import 'package:fe/data_classes/json/backend_access_tokens.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/data_classes/json/refresh_carrier.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_graphql/fresh_graphql.dart';

import 'local_file_store.dart';

class TokenManager extends TokenStorage<OAuth2Token> {
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _localFileStore = getIt<LocalFileStore>();
  final _unauthClient = getIt<UnauthHttpClient>();
  final _localUser = getIt<LocalUser>();
  bool hasTokens = false;

  OAuth2Token? _tokenCache;

  static Future<void> setTokens(BackendAccessTokens backendAccessTokens) async {
    await getIt<LocalFileStore>().serialize(
        LocalStorageType.AccessTokens, backendAccessTokens.accessToken);
    await getIt<FlutterSecureStorage>()
        .write(key: REFRESH_TOKEN_KEY, value: backendAccessTokens.refreshToken);
  }

  Future<void> initalizeTokens(BackendAccessTokens backendAccessTokens) async {
    await setTokens(backendAccessTokens);
    _tokenCache = OAuth2Token(accessToken: backendAccessTokens.accessToken);
    hasTokens = true;
  }

  Future<String?> get _refreshToken =>
      _secureStorage.read(key: REFRESH_TOKEN_KEY);

  @override
  Future<void> delete() async {
    hasTokens = false;
    await _localFileStore.delete(LocalStorageType.AccessTokens);
    _tokenCache = null;
  }

  @override
  Future<OAuth2Token> read() async {
    hasTokens = true;
    if (_tokenCache != null) {
      return _tokenCache!;
    }

    final serializedToken =
        await _localFileStore.deserialize(LocalStorageType.AccessTokens);

    if (serializedToken == null) {
      final gottenToken = await refresh();
      await write(gottenToken);
      return gottenToken;
    } else {
      return OAuth2Token(accessToken: serializedToken);
    }
  }

  @override
  Future<void> write(OAuth2Token token) async {
    _tokenCache = token;
    await _localFileStore.serialize(
        LocalStorageType.AccessTokens, token.accessToken);
  }

  Future<OAuth2Token> refresh() async {
    hasTokens = true;
    final refreshToken = await _refreshToken;
    final userId = _localUser.uuid;

    if (refreshToken == null) {
      throw NoRefreshTokenException();
    }

    final resp = await _unauthClient.postReq('/auth/refresh',
        RefreshCarrier(refreshToken: refreshToken, userId: userId).toJson());

    if (resp.statusCode != 200) {
      throw FailedRefresh();
    } else {
      return OAuth2Token(accessToken: resp.body);
    }
  }
}

class TokenException implements Exception {}

class NoRefreshTokenException extends TokenException {}

class FailedRefresh extends TokenException {}
