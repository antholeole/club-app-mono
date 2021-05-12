import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

import '../../../../../../service_locator.dart';

class GroupsService {
  final _databaseManager = getIt<DatabaseManager>();
  final _cachedGroups = <Group>[];

  final Map<UuidType, List<User>> _cachedUsers = {};

  GroupsService() {
    _beginCache();
  }

  List<Group> get cachedGroups => _cachedGroups;

  List<User> getCachedUsersInGroup(UuidType groupId) {
    return _cachedUsers[groupId] ?? [];
  }

  Future<List<Group>> fetchGroups() async {
    final allGroups = await _databaseManager.groupsDao.findAll(remote: true);

    _cachedGroups.clear();
    _cachedGroups.addAll(allGroups);
    return allGroups;
  }

  Future<List<User>> fetchUsersInGroup(UuidType groupId) async {
    final usersInGroup =
        await _databaseManager.usersDao.findAllInGroup(groupId, remote: true);
    _cachedUsers[groupId] = usersInGroup;
    return usersInGroup;
  }

  Future<void> _beginCache() async {
    final knownGroups = await _databaseManager.groupsDao.findAll();
    _cachedGroups.addAll(knownGroups);
    for (final knownGroup in knownGroups) {
      final usersInGroup =
          await _databaseManager.usersDao.findAllInGroup(knownGroup.id);
      for (final user in usersInGroup) {
        if (_cachedUsers[knownGroup.id] != null) {
          _cachedUsers[knownGroup.id] = [user];
        } else {
          _cachedUsers[knownGroup.id]!.add(user);
        }
      }
    }
  }
}
