import 'dart:io';

import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/helpers/tuple.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final GroupRepository _groupRepository = getIt<GroupRepository>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  MainService();

  Future<void> initalLoad() async {
    await _groupRepository.findAll(remote: true);
  }

  Future<void> logOut() async {
    await Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }
}
