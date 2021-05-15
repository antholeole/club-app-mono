import 'package:fe/gql/remove_self_from_group.ast.gql.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../service_locator.dart';

class GroupsService {
  final _databaseManager = getIt<DatabaseManager>();
  final _gqlClient = getIt<Client>();
  final _localUser = getIt<LocalUser>();
  final _cachedGroups = <Group>[];

  final Map<UuidType, Set<User>> _cachedUsers = {};

  List<Group> get cachedGroups => _cachedGroups;

  bool _cached = false;

  Iterable<User> getCachedUsersInGroup(UuidType groupId) {
    return _cachedUsers[groupId] ?? <User>{};
  }

  Future<List<Group>> fetchGroups({required bool remote}) async {
    final allGroups = await _databaseManager.groupsDao.findAll(remote: remote);
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

  void leaveGroup(Group group, BuildContext context, Function() willLeaveGroup,
      void Function() didLeaveGroup) {
    Future<void> leftGroup() async {
      willLeaveGroup();

      final query = GRemoveSelfFromGroupReq((q) => q
        ..vars.groupId = group.id
        ..vars.userId = _localUser.uuid);

      await _gqlClient.request(query).first;
      await _databaseManager.groupsDao.removeOne(group.id);

      //TODO: make this more specific; drop only known group, not entire cache
      _gqlClient.cache.clear();
      Toaster.of(context).successToast('Left group ${group.name}');

      //if the current group we are in in is the selected one, we should reset
      //selected group
      if (context.read<MainPageActionsCubit>().state.selectedGroup?.id !=
              null &&
          context.read<MainPageActionsCubit>().state.selectedGroup!.id ==
              group.id) {
        context.read<MainPageActionsCubit>().resetPage();
      }
      didLeaveGroup();
    }

    Toaster.of(context).warningToast(
      "Are you sure you'd like to leave ${group.name}?",
      action: leftGroup,
      actionText: 'Leave Group',
    );
  }
}
