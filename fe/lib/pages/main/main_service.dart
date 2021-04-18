import 'package:fe/data_classes/group.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/gql/query_self_group_ids.req.gql.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final Client _gqlClient = getIt<Client>();
  final LocalFileStore _localFileStore = LocalFileStore();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();

  MainService();

  Future<List<Group>> loadGroups() async {
    await _getAllGroupIds();
    return [];
  }

/*
  Future<List<Group>> _loadLocalGroups() async {
    final groups = await _localFileStore.deserialize(LocalStorageType.GroupIds);
  }

  Future<List<Group>> _loadRemoteGroups() async {}
  */

  Future<void> logOut() async {
    await Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }

  Future<List<UuidType>> _getAllGroupIds() async {
    final req = GQuerySelfGroupIdsReq((b) => b..vars.self_id = _user.uuid);

    return (await _gqlClient.request(req).first)
        .data!
        .user_to_group
        .map((v) => v.id)
        .toList();
  }
}
