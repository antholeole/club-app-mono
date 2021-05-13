import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../service_locator.dart';

class GroupsService {
  final _databaseManager = getIt<DatabaseManager>();
  final _cachedGroups = <Group>[];

  final Map<UuidType, Set<User>> _cachedUsers = {};

  List<Group> get cachedGroups => _cachedGroups;

  bool _cached = false;

  Iterable<User> getCachedUsersInGroup(UuidType groupId) {
    return _cachedUsers[groupId] ?? <User>{};
  }

  Future<List<Group>> fetchGroups() async {
    final allGroups = await _databaseManager.groupsDao.findAll(remote: true);

    _cachedGroups.clear();
    _cachedGroups.addAll(allGroups);
    return allGroups;
  }

  Future<Set<User>> fetchUsersInGroup(UuidType groupId) async {
    final usersInGroup =
        await _databaseManager.usersDao.findAllInGroup(groupId, remote: true);

    _cachedUsers[groupId] = usersInGroup.toSet();

    return _cachedUsers[groupId]!;
  }

  Future<void> cacheIfNecessary() async {
    if (_cached) {
      return;
    }

    final knownGroups = await _databaseManager.groupsDao.findAll();
    _cachedGroups.addAll(knownGroups);
    for (final knownGroup in knownGroups) {
      final usersInGroup =
          await _databaseManager.usersDao.findAllInGroup(knownGroup.id);
      for (final user in usersInGroup) {
        if (_cachedUsers[knownGroup.id] != null) {
          _cachedUsers[knownGroup.id]!.add(user);
        } else {
          _cachedUsers[knownGroup.id] = {user};
        }
      }
    }
    _cached = true;
  }
}
