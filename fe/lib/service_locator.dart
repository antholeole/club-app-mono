import 'package:fe/config.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/data_classes/isar/user_repository.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/groups/groups_service.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile/profile_page_service.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/clients/http/auth_http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/helpers/remote_sync.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'data_classes/json/local_user.dart';
import 'isar.g.dart';

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

  //pre-local user
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<SplashService>(SplashService());

  //NOTE: everything after here looks like a tangled web of dependencies;
  //in short, almost everything depends on localUser, which only signals
  //ready when the user logs in OR on app boot up from memory.
  //This means that directly after login / boot up, all the dependencies get created.
  getIt.registerSingletonAsync<LocalUser>(() async => LocalUser.empty(),
      signalsReady: true);

  getIt.registerSingletonWithDependencies<TokenManager>(() => TokenManager(),
      dependsOn: [LocalUser]);
  getIt.registerSingletonAsync<Client>(() => buildGqlClient(),
      dependsOn: [LocalUser, TokenManager]);

  //isar
  getIt.registerSingletonAsync<Isar>(() => openIsar(name: 'a'));
  getIt.registerSingletonWithDependencies<IsarSyncer>(() => IsarSyncer(),
      dependsOn: [Isar, Client]);

  //repositories
  getIt.registerSingletonWithDependencies<GroupRepository>(
      () => GroupRepository(),
      dependsOn: [IsarSyncer]);
  getIt.registerSingletonWithDependencies<UserRepository>(
      () => UserRepository(),
      dependsOn: [IsarSyncer]);

  //logged in services
  getIt.registerSingletonWithDependencies(() => AuthHttpClient(),
      dependsOn: [LocalUser]);
  getIt.registerSingletonWithDependencies(() => MainService(),
      dependsOn: [LocalUser, GroupRepository]);
  getIt.registerSingletonWithDependencies(() => ProfilePageService(),
      dependsOn: [LocalUser, Client]);
  getIt.registerSingletonWithDependencies(() => GroupsService(),
      dependsOn: [LocalUser, GroupRepository, UserRepository]);
}
