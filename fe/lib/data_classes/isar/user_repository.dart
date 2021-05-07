import 'package:fe/data_classes/isar/base_respository.dart';
import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/stdlib/helpers/remote_sync.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'isar_exceptions.dart';

class UserRepository extends BaseRepository<User> {
  final _isar = getIt<Isar>();
  final _isarSyncer = getIt<IsarSyncer>();

  Future<List<User>> findAllInGroup(UuidType groupId,
      {bool remote = false}) async {
    final localUsers = await _isar.users
        .where()
        .filter()
        .group((g) => g.idEqualTo(groupId))
        .findAll();

    debugPrint('found ${localUsers.length} users in group');

    if (!remote) {
      return localUsers;
    }

    final remoteUsers = await _isarSyncer.fetchRemote(
        GQueryUsersInGroupReq((b) => b..vars.groupId = groupId),
        (GQueryUsersInGroupData data) => data.user_to_group
            .map((user) => User()
              ..name = user.user.name
              ..profilePicture = user.user.profile_picture
              ..id = user.user.id)
            .toList());

    await _isarSyncer.remoteSync(
        this,
        localUsers,
        remoteUsers,
        (User u) => addUserWithGroup(user: u, groupId: groupId),
        (User u) => removeUserFromGroup(userId: u.id, groupId: groupId),
        (User u) => u.name);

    //regrab new data
    return findAllInGroup(groupId);
  }

  Future<void> removeUserFromGroup(
      {required UuidType userId, required UuidType groupId}) async {
    final user =
        await _isar.users.where().filter().idEqualTo(userId).findFirst();

    if (user == null) {
      throw DeleteNonexistantError();
    }

    await _isar.writeTxn((isar) async {
      final user =
          (await isar.users.where().filter().idEqualTo(userId).findFirst())!;

      //if user only exists in one group and not a dm, then we can delete him.
      //otherwise just remove that user from the group
      if (!user.hasDm && user.groups.length > 1) {
        user.groups.where((group) => group.id != groupId);
        await isar.users.put(user);
      } else {
        await isar.users.delete(user.isar_id!);
      }
    });
  }

  Future<void> addUserWithGroup(
      {required User user, required UuidType groupId}) async {
    await _isar.writeTxn((isar) async {
      user.groups
          .add((await isar.groups.where().idEqualTo(groupId).findFirst())!);

      await isar.users.put(user);
    });
  }

  @override
  Future<void> addOne(User t) async {
    await _isar.writeTxn((isar) async {
      await isar.users.put(t);
    });
  }

  @override
  Future<User?> findOne(UuidType id) async {
    await _isar.users.where().idEqualTo(id).findFirst();
  }

  @override
  Future<void> removeOne(UuidType id) async {
    final user = await _isar.users.where().idEqualTo(id).findFirst();

    if (user == null) {
      throw DeleteNonexistantError();
    }

    await _isar.writeTxn((isar) async {
      await isar.users.delete(user.isar_id!);
    });
  }

  @override
  Future<void> updateLocal(User other) async {
    await putLocal(other, _isar.users, _isar);
  }
}
