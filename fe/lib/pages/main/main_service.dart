import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/tuple.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

enum MainPageState { Loading, NoGroups, WithGroups, Error }

class MainPageInitalLoadCarrier {
  final Group? group;
  final MainPageState state;
  final Failure? failure;

  const MainPageInitalLoadCarrier(
      {this.group, required this.state, this.failure})
      : assert((failure != null && state == MainPageState.Error) ||
            (group != null && state == MainPageState.WithGroups) ||
            (group == null && state == MainPageState.NoGroups)),
        assert(state != MainPageState.Loading);
}

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final DatabaseManager _databaseManager = getIt<DatabaseManager>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  MainService();

  Future<void> logOut() {
    return Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }

  Future<MainPageInitalLoadCarrier> initalLoad() async {
    List<Group> groups;
    try {
      groups = await _databaseManager.groupsDao.findAll(remote: true);
    } on Failure catch (e) {
      return MainPageInitalLoadCarrier(
        state: MainPageState.Error,
        failure: e,
      );
    }
    if (groups.isEmpty) {
      return MainPageInitalLoadCarrier(
        state: MainPageState.NoGroups,
      );
    } else {
      return MainPageInitalLoadCarrier(
          state: MainPageState.WithGroups, group: groups[0]);
    }
  }
}
