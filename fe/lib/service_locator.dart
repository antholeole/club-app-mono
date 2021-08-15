import 'package:fe/config.dart';
import 'package:fe/services/clients/gql_client/gql_client.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/local_data/image_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:ferry/ferry.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'flows/app_state.dart';

final getIt = GetIt.instance;

void setupLocator({required bool isProd}) {
  if (isProd) {
    getIt.registerSingleton<Config>(ProdConfig());
  } else {
    getIt.registerSingleton<Config>(DevConfig());
  }

  //service cubits
  getIt.registerSingleton<ToasterCubit>(ToasterCubit());

  //allows us to test without having to setup auth every time
  getIt.registerSingleton(FlowController(AppState.loading()));

  getIt
      .registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);
  getIt.registerSingleton(ImageHandler());
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<UnauthHttpClient>(UnauthHttpClient());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<LocalFileStore>(LocalFileStore());

  getIt.registerSingletonWithDependencies<LocalUserService>(
      () => LocalUserService(),
      dependsOn: [SharedPreferences]);
  getIt.registerSingletonWithDependencies<TokenManager>(() => TokenManager(),
      dependsOn: [LocalUserService]);
  getIt.registerSingletonAsync<Client>(() => buildGqlClient(),
      dependsOn: [TokenManager]);
  getIt.registerSingletonWithDependencies(() => WsClient(),
      dependsOn: [TokenManager]);
}
