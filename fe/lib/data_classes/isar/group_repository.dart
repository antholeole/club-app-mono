import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/helpers/remote_sync.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'group.dart';

class GroupRepository {
  final _isar = getIt<Isar>();
  final _user = getIt<LocalUser>();

  GroupRepository();

  Future<List<Group>> findAll({bool remote = false}) async {
    final localGroups = await _isar.groups.where().findAll();

    if (!remote) {
      return localGroups;
    }

    final remoteGroups = await fetchRemote(
        GQuerySelfGroupsPreviewReq((b) => b..vars.self_id = _user.uuid),
        (GQuerySelfGroupsPreviewData data) => data.user_to_group
            .map((v) => Group()
              ..id = v.group.id
              ..name = v.group.group_name)
            .toList());

    await remoteSync(localGroups, remoteGroups, addOne,
        (Group g) => removeById(g.id), (Group g) => g.name);

    //regrab new data
    return findAll();
  }

  Future<void> addOne(Group group) async {
    await _isar.writeTxn((isar) async {
      await isar.groups.put(group);
    });
  }

  Future<bool> removeById(UuidType id) async {
    return await _isar.writeTxn((isar) async {
      return await isar.groups.where().filter().idEqualTo(id).deleteFirst();
    });
  }
}
