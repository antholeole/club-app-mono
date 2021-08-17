import 'dart:convert';

import 'package:fe/data/models/user.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_file_store.dart';

const _USER_ID_KEY = 'user:id:self';

class LocalUserService {
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  // returns userId, from close storage if possible.
  // prefer this ove getLoggedInUsr.
  Future<UuidType> getLoggedInUserId() async {
    if (_sharedPreferences.containsKey(_USER_ID_KEY)) {
      return UuidType(_sharedPreferences.getString(_USER_ID_KEY)!);
    } else {
      final user = await getLoggedInUser();
      await _sharedPreferences.setString(_USER_ID_KEY, user.id.uuid);
      return user.id;
    }
  }

  Future<User> getLoggedInUser() async {
    final userStr =
        await _localFileStore.deserialize(LocalStorageType.LocalUser);

    if (userStr == null) {
      throw const Failure(status: FailureStatus.NotLoggedIn);
    }

    return User.fromJson(json.decode(userStr));
  }

  Future<void> logOut() async {
    await Future.wait([_localFileStore.clear(), _secureStorage.deleteAll()]);
  }

  Future<void> saveChanges(User other) {
    return _localFileStore.serialize(
        LocalStorageType.LocalUser, json.encode(other));
  }
}