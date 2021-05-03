import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/isar.g.dart';
import 'package:fe/stdlib/helpers/tuple.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/isar_manager.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final GroupRepository _groupRepository = getIt<GroupRepository>();
  final Client _gqlClient = getIt<Client>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  MainService();

  Future<void> initalLoad() async {
    //if any remote groups do not exist locally, create them.
    //if any local groups do not exist remotely, delete them.
    List<Tuple<UuidType, String>> remoteGroups = [];
    List<Group> localGroups = [];

    await Future.wait<void>([
      _getRemoteGroupIds().then((remotes) => remoteGroups = remotes),
      _groupRepository.findAll().then((locals) => localGroups = locals)
    ]);

    List<Future<void>> groupChanges = [];
    for (Tuple<UuidType, String> remoteGroup in remoteGroups) {
      if (localGroups
              .indexWhere((localGroup) => localGroup.id == remoteGroup.item1) <
          0) {
        debugPrint('adding group ${remoteGroup.item2} locally');
        groupChanges.add(_groupRepository.addOne(Group()
          ..name = remoteGroup.item2
          ..id = remoteGroup.item1));
      }
    }

    for (Group localGroup in localGroups) {
      if (remoteGroups
              .indexWhere((remoteGroup) => localGroup.id == remoteGroup.item1) <
          0) {
        debugPrint('removing group ${localGroup.name} locally');
        groupChanges.add(_groupRepository.removeById(localGroup.id));
      }
    }

    await Future.wait(groupChanges);
  }

  Future<void> logOut() async {
    await Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }

  Future<List<Tuple<UuidType, String>>> _getRemoteGroupIds() async {
    final req = GQuerySelfGroupsPreviewReq((b) => b..vars.self_id = _user.uuid);

    return (await _gqlClient.request(req).first)
        .data!
        .user_to_group
        .map((v) => Tuple(item1: v.group.id, item2: v.group.group_name))
        .toList();
  }
}
