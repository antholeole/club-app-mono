import 'package:fe/config.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/local_data/image_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'fixtures/mocks.dart';
import 'testing_config.dart';

Future<void> registerAllServices({needCubitAutoEvents = false}) {
  getIt.allowReassignment = true;

  getIt.registerSingleton<TokenManager>(MockTokenManager());
  getIt.registerSingleton<LocalFileStore>(MockLocalFileStore.getMock());
  getIt.registerSingleton<WsClient>(MockWsClient.getMock()..emptyStub());
  getIt.registerSingleton<LocalUserService>(MockLocalUserService());
  getIt.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  getIt.registerSingleton<ImageHandler>(MockImageHandler.getMock());
  getIt.registerSingleton<UnauthHttpClient>(MockUnauthHttpClient());
  getIt.registerSingleton(FlowController(AppState.loading()));
  getIt.registerSingleton<http.Client>(MockHttpClient.getMock());
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => MockSharedPreferences());
  getIt.registerSingleton<Client>(MockGqlClient.getMock());

  getIt.registerSingleton<Config>(
      TestingConfig(needAutoEvents: needCubitAutoEvents));

  return getIt.allReady();
}
