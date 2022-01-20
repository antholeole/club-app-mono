import 'package:connectivity/connectivity.dart';
import 'package:fe/config.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';
import 'package:fe/services/local_data/image_cache_handler.dart';

import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'mocks.dart';
import 'testing_config.dart';

Future<void> registerAllMockServices() {
  getIt.allowReassignment = true;

  getIt.registerSingleton<TokenManager>(MockTokenManager.getMock());
  getIt.registerSingleton<LocalFileStore>(MockLocalFileStore.getMock());
  getIt.registerSingleton<LocalUserService>(MockLocalUserService());
  getIt.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  getIt.registerSingleton<ImageCacheHandler>(MockImageCacheHandler.getMock());
  getIt.registerSingleton<GoogleSignIn>(MockGoogleSignIn());
  getIt.registerSingleton(FlowController(const AppState.loading()));
  getIt.registerSingleton<http.Client>(MockHttpClient.getMock());
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => MockSharedPreferences());
  getIt.registerSingleton<AuthGqlClient>(MockGqlClient.getMock());
  getIt.registerSingleton<UnauthGqlClient>(MockUnauthGqlClient());
  getIt.registerSingleton<Connectivity>(MockConnectivity());
  getIt.registerSingleton<Handler>(MockHandler.getMock());

  getIt.registerSingleton<Config>(TestingConfig());

  return getIt.allReady();
}
