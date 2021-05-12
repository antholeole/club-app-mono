import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final DatabaseManager _databaseManager = getIt<DatabaseManager>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  MainService();

  Future<List<Group>> initalLoad() {
    return _databaseManager.groupsDao.findAll(remote: true);
  }

  Future<void> logOut() {
    return Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }
}
