import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/config.dart';
import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/login/view/widgets/sign_in_with_provider_button.dart';
import 'package:fe/services/local_data/image_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:flutter/widgets.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service_locator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final ImageHandler _imageHandler = getIt<ImageHandler>();
  final Config _config = getIt<Config>();

  SplashCubit() : super(SplashState.initial()) {
    if (!_config.testing) beginLoads();
  }

  void beginLoads() async {
    // ignore: unawaited_futures
    _beginLoadingImagesFromLoginPage();

    final user = await _loadPreExistingUserFromMemory();
    await _waitForEssentialLoadsToComplete();

    if (user != null) {
      emit(SplashState.loggedIn(user));
    } else {
      emit(SplashState.notLoggedIn());
    }
  }

  Future<void> _beginLoadingImagesFromLoginPage() async {
    List<Future<dynamic>> futures = [];

    for (final provider in LoginType.values) {
      futures.add(_imageHandler.preCache(AssetImage(provider.imageLocation)));
    }

    await Future.wait(futures);
  }

  //returns true if user exists, false if it doesn't.
  Future<User?> _loadPreExistingUserFromMemory() async {
    final localUserString =
        await _localFileStore.deserialize(LocalStorageType.LocalUser);

    if (localUserString != null) {
      final localUser = User.fromJson(json.decode(localUserString));
      await getIt.allReady();
      return localUser;
    }
  }

  Future<void> _waitForEssentialLoadsToComplete() async {
    await Future.wait([getIt.isReady<SharedPreferences>()]);
  }
}
