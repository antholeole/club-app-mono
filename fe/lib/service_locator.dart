import 'package:connectivity/connectivity.dart';
import 'package:fe/config.dart';
import 'package:fe/firebase_options.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/services/clients/notification_client.dart';
import 'package:fe/services/local_data/image_cache_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator({required bool isProd}) {
  if (isProd) {
    getIt.registerSingleton<Config>(ProdConfig());
  } else {
    getIt.registerSingleton<Config>(LocalConfig());
  }

  getIt.registerSingleton<Connectivity>(Connectivity());

  getIt.registerSingleton<GoogleSignIn>(GoogleSignIn(
    scopes: [],
  ));

  getIt.registerSingleton<ImagePicker>(ImagePicker());

  //required to dependency inject app state
  getIt.registerSingleton(FlowController(const AppState.loading()));

  //firebase shit
  getIt.registerSingletonAsync<FirebaseApp>(() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  getIt.registerSingletonWithDependencies<FirebaseMessaging>(
      () => FirebaseMessaging.instance,
      dependsOn: [FirebaseApp]);

  getIt
      .registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);
  getIt.registerSingleton(ImageCacheHandler());
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<LocalFileStore>(LocalFileStore());
  getIt.registerSingleton<Handler>(Handler());
  getIt.registerSingletonAsync<UnauthGqlClient>(() => UnauthGqlClient.build());

  getIt.registerSingletonWithDependencies<LocalUserService>(
      () => LocalUserService(),
      dependsOn: [SharedPreferences]);
  getIt.registerSingletonWithDependencies<TokenManager>(() => TokenManager(),
      dependsOn: [LocalUserService, UnauthGqlClient]);

  getIt.registerSingletonAsync<AuthGqlClient>(() => AuthGqlClient.build(),
      dependsOn: [TokenManager]);

  getIt.registerSingletonWithDependencies(() => ImageClient(),
      dependsOn: [AuthGqlClient]);
  getIt.registerSingletonWithDependencies<NotificationClient>(
      () => NotificationClient(),
      dependsOn: [AuthGqlClient, FirebaseMessaging]);
}
