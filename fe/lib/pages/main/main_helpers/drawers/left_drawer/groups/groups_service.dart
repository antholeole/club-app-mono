import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/data_classes/isar/user_repository.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

import '../../../../../../service_locator.dart';

class GroupsService {
  final _groupRepository = getIt<GroupRepository>();
  final _userRepository = getIt<UserRepository>();
  final _cachedGroups = <Group>[];
  final Map<UuidType, List<User>> _cachedUsers = {};

  GroupsService() {
    _groupRepository.findAll().then((knownGroups) {
      _cachedGroups.addAll(knownGroups);
      knownGroups.forEach((knownGroup) {
        _cachedUsers[knownGroup.id] = knownGroup.users.toList();
      });
    });
  }

  List<Group> get cachedGroups => _cachedGroups;

  List<User> getCachedUsersInGroup(UuidType groupId) {
    return _cachedUsers[groupId] ?? [];
  }

  Future<List<Group>> fetchGroups() async {
    final allGroups = await _groupRepository.findAll(remote: true);
    _cachedGroups.clear();
    _cachedGroups.addAll(allGroups);
    return allGroups;
  }

  Future<List<User>> fetchUsersInGroup(UuidType groupId) async {
    final usersInGroup =
        await _userRepository.findAllInGroup(groupId, remote: true);
    _cachedUsers[groupId] = usersInGroup;
    return usersInGroup;
  }
}
