import 'package:fe/data_classes/isar/base_respository.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/helpers/remote_sync.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'group.dart';

class GroupRepository extends BaseRepository<Group> {
  final _isar = getIt<Isar>();
  final _user = getIt<LocalUser>();
  final _isarSyncer = getIt<IsarSyncer>();

  GroupRepository();

  Future<List<Group>> findAll({bool remote = false}) async {
    final localGroups = await _isar.groups.where().findAll();

    if (!remote) {
      return localGroups;
    }

    final remoteGroups = await _isarSyncer.fetchRemote(
        GQuerySelfGroupsPreviewReq((b) => b..vars.self_id = _user.uuid),
        (GQuerySelfGroupsPreviewData data) => data.user_to_group
            .map((v) => Group()
              ..id = v.group.id
              ..name = v.group.group_name)
            .toList());

    await _isarSyncer.remoteSync(this, localGroups, remoteGroups, addOne,
        (Group g) => removeOne(g.id), (Group g) => g.name);

    //regrab new data
    return findAll();
  }

  @override
  Future<void> addOne(Group group) async {
    await _isar.writeTxn((isar) async {
      await isar.groups.put(group);
    });
  }

  @override
  Future<bool> removeOne(UuidType id) async {
    return await _isar.writeTxn((isar) async {
      return await isar.groups.where().filter().idEqualTo(id).deleteFirst();
    });
  }

  @override
  Future<Group?> findOne(UuidType id) async {
    return _isar.groups.where().idEqualTo(id).findFirst();
  }

  @override
  Future<void> updateLocal(Group other) async {
    await putLocal(other, _isar.groups, _isar);
  }
}
