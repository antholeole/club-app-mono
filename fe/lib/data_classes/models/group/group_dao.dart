import 'package:fe/data_classes/models/base/base_dao.dart';
import 'package:fe/data_classes/models/group/group_table.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/database/remote_sync.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:moor/moor.dart';

import '../../../service_locator.dart';

part 'group_dao.g.dart';

@UseDao(tables: [Groups])
class GroupsDao extends BaseDao<Group> with _$GroupsDaoMixin {
  final RemoteSyncer _remoteSyncer = getIt<RemoteSyncer>();
  final LocalUser _localUser = getIt<LocalUser>();

  GroupsDao(DatabaseManager db) : super(db);

  @override
  Future<void> addOne(Group entry) {
    return into(groups).insert(entry);
  }

  @override
  Future<Group?> findOne(UuidType id) {
    return (select(groups)..where((tbl) => tbl.id.equals(id.uuid)))
        .getSingleOrNull();
  }

  @override
  Future<void> removeOne(UuidType id) async {
    await (delete(groups)..where((tbl) => tbl.id.equals(id.uuid))).go();
  }

  Future<List<Group>> findAll({bool remote = false}) async {
    final localGroups = await select(groups).get();

    if (!remote) {
      return localGroups;
    }

    final remoteGroups = await _remoteSyncer.fetchRemote(
        GQuerySelfGroupsPreviewReq((b) => b..vars.self_id = _localUser.uuid),
        (GQuerySelfGroupsPreviewData data) => data.user_to_group
            .map((v) => Group(id: v.group.id, name: v.group.group_name))
            .toList());

    await _remoteSyncer.remoteSync(this, localGroups, remoteGroups, addOne,
        (Group g) => removeOne(g.id), (Group g) => g.name);

    return findAll(remote: false);
  }

  @override
  Future<bool> overrideLocal(Group other) {
    return update(groups).replace(other);
  }
}
