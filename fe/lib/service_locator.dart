import 'package:fe/config.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile_page/profile_page_service.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/clients/http/auth_http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'data_classes/json/local_user.dart';

final getIt = GetIt.instance;

void setupLocator({required bool isProd}) {
  if (isProd) {
    getIt.registerSingleton<Config>(ProdConfig());
  } else {
    getIt.registerSingleton<Config>(DevConfig());
  }

  //general deps
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getIt.registerSingleton<UnauthHttpClient>(UnauthHttpClient());
  getIt.registerSingleton<LocalFileStore>(LocalFileStore());
  getIt.registerSingleton<LocalUser>(LocalUser.empty());

  //async general dep
  //getIt.registerSingletonAsync<Isar>(() async => openIsar());

  //only services that can be registered pre-login
  //(does not dep on localUserAuth)
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<SplashService>(SplashService());

  //must be lazy due to depending on LocalUser being logged in.
  //using prior to logging in will throw an error.
  getIt.registerLazySingleton<Client>(() => buildGqlClient(getIt<LocalUser>()));
  getIt.registerLazySingleton<AuthHttpClient>(
      () => AuthHttpClient(getIt<LocalUser>()));

  //logged in services
  getIt.registerLazySingleton(() => MainService());
  getIt.registerLazySingleton(() => ProfilePageService());
}
