import 'dart:convert';

import 'package:fe/constants.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../service_locator.dart';

part 'local_user.g.dart';

//user stored on device, with various helper functions and
//properties.
@JsonSerializable()
@CustomUuidConverter()
class LocalUser {
  final _secureStorage = getIt<FlutterSecureStorage>();

  String name;
  late UuidType uuid;
  String? email;

  //need default constructor for to and from json
  LocalUser({String? name, required this.uuid, this.email})
      : name = name ?? DEFAULT_USERNAME;

  void login(LocalUser user) {
    user.name;
    uuid = user.uuid;
    email = user.email;
  }

  //compliance consturctor for getIt. will never signal ready;
  //will only signal ready in reregister
  LocalUser.empty() : name = DEFAULT_USERNAME;

  factory LocalUser.fromJson(String jsonString) =>
      _$LocalUserFromJson(json.decode(jsonString));

  bool isLoggedIn() {
    // ignore: unnecessary_null_comparison
    return (uuid != null);
  }

  Future<void> logOut() async {
    await _secureStorage.containsKey(key: REFRESH_TOKEN_KEY);
  }

  Future<void> serializeSelf() async {
    await getIt<LocalFileStore>()
        .serialize(LocalStorageType.LocalUser, json.encode(toJson()));
  }

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

enum LoginType { Google }

class NotLoggedInError extends Error {}
