import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class SplashService {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();

  //so we don't have ugly asset loads infront of the user
  Future<void> beginLoadingImagesFromLoginPage(BuildContext context) async {
    List<Future<dynamic>> futures = [];

    for (final provider in LoginType.values) {
      futures.add(precacheImage(AssetImage(provider.imageLocation), context));
    }

    await Future.wait(futures);
  }

  //returns true if user exists, false if it doesn't.
  Future<bool> loadPreExistingUserFromMemory() async {
    final localUserString =
        await _localFileStore.deserialize(LocalStorageType.LocalUser);

    if (localUserString != null) {
      final localUser = LocalUser.fromJson(localUserString);
      if (localUser.isLoggedIn()) {
        getIt<LocalUser>().fromUser(localUser);
        return true;
      }
    }

    return false;
  }
}
