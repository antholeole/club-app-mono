import 'package:fe/conn_clients/http_client.dart';
import 'package:fe/constants.dart';
import 'package:fe/data_classes/backend_access_tokens.dart';
import 'package:fe/data_classes/refresh_carrier.dart';
import 'package:fe/data_classes/user.dart';
import 'package:fe/helpers/uuid_type.dart';
import 'package:fe/local_data/local_file_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../service_locator.dart';

//user stored on device, with various helper functions and
//properties.
enum LoginType { Google }

class LocalUser {
  final _secureStorage = getIt<FlutterSecureStorage>();

  late String _name;
  late UuidType _uuid;
  late LoginType _loggedInWith;
  late String _accessToken;

  String? _email;

  LocalUser();

  LocalUser.fromUser(User user) {
    _name = user.name;
    _uuid = user.uuid;
    _loggedInWith = user.loggedInWith;
    _accessToken = user.accessToken;
    _email = user.email;
  }

  User toUser() {
    return User(
        accessToken: accessToken,
        loggedInWith: _loggedInWith,
        name: _name,
        uuid: _uuid,
        email: _email);
  }

  String get name {
    return _name;
  }

  String? get email {
    return _email;
  }

  String get accessToken {
    return _accessToken;
  }

  UuidType get id {
    return _uuid;
  }

  Future<String> get _refreshToken async {
    return (await _secureStorage.read(key: REFRESH_TOKEN_KEY))!;
  }

  void providerLogin(LoginType loginType, String? displayName, String? email) {
    _loggedInWith = loginType;
    _name = displayName ?? DEFAULT_USERNAME;
    _email = email;
  }

  bool isLoggedIn() {
    // ignore: unnecessary_null_comparison
    return (_uuid != null && _loggedInWith != null);
  }

  Future<void> backendLogin(BackendAccessTokens t) async {
    _uuid = UuidType(t.id);
    _accessToken = t.accessToken;
    _name = t.name;
    await _secureStorage.write(key: REFRESH_TOKEN_KEY, value: t.refreshToken);
  }

  Future<void> refreshAccessToken() async {
    final resp = await getIt<HttpClient>().postReq(
        '/auth/refresh',
        RefreshCarrier(refreshToken: await _refreshToken, userId: _uuid)
            .toJson());

    _accessToken = resp.body;
  }

  Future<void> serializeSelf() async {
    await LocalFileStore()
        .serialize(LocalStorageType.LocalUser, toUser().toJson());
  }
}

class NotLoggedInError extends Error {}
