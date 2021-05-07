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
  String? email;

  //need default constructor for to and from json
  LocalUser(
      {required this.name,
      required this.uuid,
      required this.loggedInWith,
      this.email});

  //compliance consturctor for getIt. will never signal ready;
  //will only signal ready in reregister
  LocalUser.empty() : name = DEFAULT_USERNAME;

  factory LocalUser.fromJson(String jsonString) =>
      _$LocalUserFromJson(json.decode(jsonString));

  factory LocalUser.fromBackendLogin(
      BackendAccessTokens t, LoginType loggedInWith) {
    return LocalUser(
        name: t.name, loggedInWith: loggedInWith, uuid: UuidType(t.id));
  }

  bool isLoggedIn() {
    // ignore: unnecessary_null_comparison
    return (uuid != null && loggedInWith != null);
  }

  Future<void> logOut() async {
    await _secureStorage.containsKey(key: REFRESH_TOKEN_KEY);
    getIt.unregister();
  }

  void providerLogin(LoginType loggedInWith, String email,
      {String? name = DEFAULT_USERNAME}) {
    this.loggedInWith = loggedInWith;
    this.email = email;
    this.name = name!;
  }

  Future<void> serializeSelf() async {
    await getIt<LocalFileStore>()
        .serialize(LocalStorageType.LocalUser, json.encode(toJson()));
  }

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);

  static void register(LocalUser localUser) {
    try {
      getIt.unregister(instance: LocalUser);
    } catch (_) {
      //IGNORED. get_it has bug that
      //if an element is not ready, but registered,
      //it is not detected but we cannot register over it.
      //this means the only way to unregister is to unregister and pray.
      //i.e. getIt.isReady(LocalUser) does not work.
    }

    getIt.registerSingleton(localUser);
    getIt.signalReady(LocalUser);
  }
}

enum LoginType { Google }

class NotLoggedInError extends Error {}
