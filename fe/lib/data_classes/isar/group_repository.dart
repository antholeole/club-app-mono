import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'group.dart';

class GroupRepository {
  final _isar = getIt<Isar>();
  final _gqlClient = getIt<Client>();
  final _user = getIt<LocalUser>();

  GroupRepository();

  Future<List<Group>> findAll({bool remote = false}) async {
    final localGroups = await _isar.groups.where().findAll();

    if (!remote) {
      return localGroups;
    }

    final req = GQuerySelfGroupsPreviewReq((b) => b..vars.self_id = _user.uuid);

    final resp = await _gqlClient.request(req).first;

    if (resp.data == null) {
      throw await basicGqlErrorHandler(errors: resp.graphqlErrors);
    }

    final data = resp.data!;

    final remoteGroups = data.user_to_group
        .map((v) => Group()
          ..id = v.group.id
          ..name = v.group.group_name)
        .toList();

    await _remoteSync(localGroups, remoteGroups);

    //TODO: can refactor so remote sync returns the updated list
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

  //verifies that remote data is the same as local.
  //treats local as a cache -> prioritize remote
  Future<void> _remoteSync(List<Group> local, List<Group> remote) {
    List<Future<void>> groupChanges = [];
    for (Group remoteGroup in remote) {
      if (local.indexWhere((localGroup) => localGroup.id == remoteGroup.id) <
          0) {
        debugPrint('adding group ${remoteGroup.name} locally');
        groupChanges.add(addOne(remoteGroup));
      }
    }

    for (Group localGroup in local) {
      if (remote.indexWhere((remoteGroup) => localGroup.id == remoteGroup.id) <
          0) {
        debugPrint('removing group ${localGroup.name} locally');
        groupChanges.add(removeById(localGroup.id));
      }
    }

    return Future.wait(groupChanges);
  }
}
