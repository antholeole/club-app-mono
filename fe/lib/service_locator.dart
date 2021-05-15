import 'package:fe/config.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/groups/groups_service.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile/profile_page_service.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/clients/http/auth_http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/database/remote_sync.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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

  //pre-local user
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<SplashService>(SplashService());

  getIt.registerSingleton<TokenManager>(TokenManager());
  getIt.registerSingletonAsync<Client>(() => buildGqlClient());

  getIt.registerSingleton<DatabaseManager>(DatabaseManager());
  getIt.registerSingletonWithDependencies<RemoteSyncer>(() => RemoteSyncer(),
      dependsOn: [Client]);

  //logged in services
  getIt.registerSingleton(AuthHttpClient());
  getIt.registerSingleton(MainService());
  getIt.registerSingletonWithDependencies(() => ProfilePageService(),
      dependsOn: [Client]);
  getIt.registerSingletonWithDependencies(() => GroupsService(),
      dependsOn: [Client]);
}
