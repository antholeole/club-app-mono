import 'package:fe/constants.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/json/refresh_carrier.dart';
import 'package:fe/service_locator.dart';

import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/gql_req_or_throw_failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_file_store.dart';
import 'local_user_service.dart';

class TokenManager {
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _localFileStore = getIt<LocalFileStore>();
  final _localUserService = getIt<LocalUserService>();
  final _gqlClient = getIt<Client>();

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

  Future<String> refresh() async {
    final refreshToken = await _refreshToken;

    UuidType userId = await _localUserService.getLoggedInUserId();

    if (refreshToken == null) {
      throw const Failure(status: FailureStatus.RefreshFail);
    }

    gqlReqOrThrowFailure(request, gqlClient)

    try {
      final resp = await _unauthClient.postReq('/auth/refresh',
          RefreshCarrier(refreshToken: refreshToken, userId: userId).toJson());
      await _writeAccessToken(resp.body);
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

  Future<void> _writeAccessToken(String accessToken) async {
    _tokenCache = accessToken;
    await _localFileStore.serialize(LocalStorageType.AccessTokens, accessToken);
  }
}
