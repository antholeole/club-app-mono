import 'package:fe/data_classes/models/base/base_dao.dart';
import 'package:fe/data_classes/models/user/user_table.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/database/remote_sync.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:moor/moor.dart';

import '../../../service_locator.dart';

part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UsersDao extends BaseDao<User> with _$UsersDaoMixin {
  final _remoteSyncer = getIt<RemoteSyncer>();

  UsersDao(DatabaseManager db) : super(db);

  @override
  Future<void> addOne(User entry) {
    return into(users).insert(entry);
  }

  @override
  Future<User?> findOne(UuidType id) {
    return (select(users)..where((tbl) => tbl.id.equals(id.uuid)))
        .getSingleOrNull();
  }

  @override
  Future<void> removeOne(UuidType id) async {
    await (delete(db.userToGroup)..where((tbl) => tbl.userId.equals(id.uuid)))
        .go();
    await (delete(users)..where((tbl) => tbl.id.equals(id.uuid))).go();
  }

  Future<List<User>> findAllInGroup(UuidType groupId,
      {bool remote = false}) async {
    final userIds = await (select(db.userToGroup)
          ..where((table) => table.groupId.equals(groupId.uuid)))
        .get();

    final t = userIds.map((e) => ((select(users)
          ..where((table) => table.id.equals(e.userId.uuid)))
        .getSingle()));

    final localUsers = await Future.wait(t);

    if (!remote) {
      return localUsers;
    }

    final remoteUsers = await _remoteSyncer.fetchRemote(
        GQueryUsersInGroupReq((b) => b..vars.groupId = groupId),
        (GQueryUsersInGroupData data) => data.user_to_group
            .map((v) => User(id: v.user.id, name: v.user.name, hasDm: false))
            .toList());

    await _remoteSyncer.remoteSync(
        this,
        localUsers,
        remoteUsers,
        (User g) => addOneWithGroup(g, groupId),
        (User g) => removeOne(g.id),
        (User g) => g.name);

    return findAllInGroup(groupId, remote: false);
  }

  @override
  Future<void> overrideLocal(User other) {
    return update(users).replace(other);
  }

  Future<void> addOneWithGroup(User other, UuidType groupId) async {
    await addOne(other);
    await into(db.userToGroup).insert(
        UserToGroupCompanion(groupId: Value(groupId), userId: Value(other.id)));
  }
}
