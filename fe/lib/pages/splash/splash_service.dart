import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/login/widgets/sign_in_with_provider_button.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

class SplashService {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();

  SplashService();

  //so we don't have ugly asset loads infront of the user
  Future<void> beginLoadingImagesFromLoginPage(BuildContext context) async {
    List<Future<dynamic>> futures = [];

    for (final provider in LoginType.values) {
      futures.add(SignInWithProviderButton.preCache(context, provider));
    }

    await Future.wait(futures);
  }

  //returns true if user exists, false if it doesn't.
  Future<User?> loadPreExistingUserFromMemory() async {
    final localUserString =
        await _localFileStore.deserialize(LocalStorageType.LocalUser);

    if (localUserString != null) {
      final localUser = User.fromJson(localUserString);
      await getIt.allReady();
      return localUser;
    }
  }

  Future<void> essentialLoadsFuture() async {
    await Future.wait([getIt.isReady<SharedPreferences>()]);
  }
}
