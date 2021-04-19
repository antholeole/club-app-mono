import 'dart:convert';

import 'package:fe/constants.dart';
import 'package:fe/data_classes/json/refresh_carrier.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../service_locator.dart';
import 'backend_access_tokens.dart';

part 'local_user.g.dart';

//user stored on device, with various helper functions and
//properties.
@JsonSerializable()
@CustomUuidConverter()
class LocalUser {
  final _secureStorage = getIt<FlutterSecureStorage>();

  String name;
  late UuidType uuid;
  late LoginType loggedInWith;
  late String accessToken;

  String? email;

  //need default constructor for to and from json
  LocalUser(
      {required this.name,
      required this.uuid,
      required this.loggedInWith,
      required this.accessToken,
      this.email});

  LocalUser.empty() : name = DEFAULT_USERNAME;

  factory LocalUser.fromJson(String jsonString) =>
      _$LocalUserFromJson(json.decode(jsonString));

  Future<String> get _refreshToken async {
    return (await _secureStorage.read(key: REFRESH_TOKEN_KEY))!;
  }

  Future<void> backendLogin(BackendAccessTokens t) async {
    debugPrint('Backend login triggered, uuid ${t.id}');
    uuid = UuidType(t.id);
    accessToken = t.accessToken;
    name = t.name;
    await _secureStorage.write(key: REFRESH_TOKEN_KEY, value: t.refreshToken);
  }

  void fromUser(LocalUser user) {
    user.name;
    uuid = user.uuid;
    loggedInWith = user.loggedInWith;
    accessToken = user.accessToken;
    email = user.email;
  }

  bool isLoggedIn() {
    // ignore: unnecessary_null_comparison
    return (uuid != null && loggedInWith != null);
  }

  Future<void> logOut() async {
    await _secureStorage.containsKey(key: REFRESH_TOKEN_KEY);
  }

  void providerLogin(LoginType loggedInWith, String email,
      {String? name = DEFAULT_USERNAME}) {
    this.loggedInWith = loggedInWith;
    this.email = email;
    this.name = name!;
  }

  Future<void> refreshAccessToken() async {
    final resp = await getIt<UnauthHttpClient>().postReq(
        '/auth/refresh',
        RefreshCarrier(refreshToken: await _refreshToken, userId: uuid)
            .toJson());

    accessToken = resp.body;
  }

  Future<void> serializeSelf() async {
    await getIt<LocalFileStore>()
        .serialize(LocalStorageType.LocalUser, toJson());
  }

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

enum LoginType { Google }

class NotLoggedInError extends Error {}
