import 'dart:convert';

import 'package:fe/stdlib/clients/http_client.dart';
import 'package:fe/constants.dart';
import 'package:fe/data_classes/backend_access_tokens.dart';
import 'package:fe/data_classes/refresh_carrier.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

import '../service_locator.dart';

part 'local_user.g.dart';

//user stored on device, with various helper functions and
//properties.
enum LoginType { Google }

@JsonSerializable()
@CustomUuidConverter()
class LocalUser {
  final _secureStorage = getIt<FlutterSecureStorage>();

  String name;
  late UuidType uuid;
  LoginType loggedInWith;
  late String accessToken;

  String? email;

  LocalUser(
      {required this.name,
      required this.uuid,
      required this.loggedInWith,
      required this.accessToken,
      this.email});

  Future<String> get _refreshToken async {
    return (await _secureStorage.read(key: REFRESH_TOKEN_KEY))!;
  }

  LocalUser.fromProviderLogin(this.loggedInWith, this.email,
      {String? name = DEFAULT_USERNAME})
      : name = name!;

  bool isLoggedIn() {
    // ignore: unnecessary_null_comparison
    return (uuid != null && loggedInWith != null);
  }

  Future<void> backendLogin(BackendAccessTokens t) async {
    uuid = UuidType(t.id);
    accessToken = t.accessToken;
    name = t.name;
    await _secureStorage.write(key: REFRESH_TOKEN_KEY, value: t.refreshToken);
  }

  Future<void> refreshAccessToken() async {
    final resp = await getIt<HttpClient>().postReq(
        '/auth/refresh',
        RefreshCarrier(refreshToken: await _refreshToken, userId: uuid)
            .toJson());

    accessToken = resp.body;
  }

  Future<void> serializeSelf() async {
    await LocalFileStore().serialize(LocalStorageType.LocalUser, toJson());
  }

  factory LocalUser.fromJson(String jsonString) =>
      _$LocalUserFromJson(json.decode(jsonString));
  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

class NotLoggedInError extends Error {}
