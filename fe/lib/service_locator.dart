import 'package:fe/config.dart';
import 'package:fe/stdlib/clients/http_client.dart';
import 'package:fe/pages/login/login_service.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
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
  getIt.registerSingleton<HttpClient>(HttpClient());
  getIt.registerSingleton<LocalFileStore>(LocalFileStore());

  //services
  getIt.registerSingleton<LoginService>(LoginService());
}
