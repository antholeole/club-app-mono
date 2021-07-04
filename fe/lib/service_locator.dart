import 'package:fe/config.dart';
import 'package:fe/pages/chat/chat_service.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/pages/main/main_helpers/scaffold/drawers/left_drawer/groups/groups_service.dart';
import 'package:fe/pages/main/main_helpers/scaffold/drawers/left_drawer/profile/profile_page_service.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/clients/gql_client/gql_client.dart';
import 'package:fe/stdlib/clients/http_client/unauth_http_client.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator({required bool isProd}) {
  if (isProd) {
    getIt.registerSingleton<Config>(ProdConfig());
  } else {
    getIt.registerSingleton<Config>(DevConfig());
  }

  getIt
      .registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);

  //general http client
  getIt.registerSingleton<http.Client>(http.Client());

  //custom http client
  getIt.registerSingleton<UnauthHttpClient>(UnauthHttpClient());

  //general deps
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getIt.registerSingleton<LocalFileStore>(LocalFileStore());
  getIt.registerSingletonWithDependencies<LocalUserService>(
      () => LocalUserService(),
      dependsOn: [SharedPreferences]);

  //pre-local user
  getIt.registerSingletonWithDependencies<LoginService>(() => LoginService(),
      dependsOn: [SharedPreferences]);
  getIt.registerSingletonWithDependencies<TokenManager>(() => TokenManager(),
      dependsOn: [LocalUserService]);
  getIt.registerSingleton<SplashService>(SplashService());

  getIt.registerSingletonAsync<Client>(() => buildGqlClient(),
      dependsOn: [TokenManager]);

  //logged in services
  getIt.registerSingletonWithDependencies(() => MainService(),
      dependsOn: [Client]);
  getIt.registerSingletonWithDependencies(() => ProfilePageService(),
      dependsOn: [Client]);
  getIt.registerSingletonWithDependencies(() => GroupsService(),
      dependsOn: [Client]);
  getIt.registerSingletonWithDependencies(() => ChatService(),
      dependsOn: [Client]);
}
