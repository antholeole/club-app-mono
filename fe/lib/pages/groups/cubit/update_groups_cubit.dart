import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/random_string.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.req.gql.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.data.gql.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/upsert_group_join_token.req.gql.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

part 'update_groups_state.dart';
part 'data_carriers/groups_page_group.dart';

class UpdateGroupsCubit extends Cubit<UpdateGroupsState> {
  final LocalUserService _localUserService = getIt<LocalUserService>();
  final _gqlClient = getIt<AuthGqlClient>();
  final Config config = getIt<Config>();

  UpdateGroupsCubit() : super(UpdateGroupsState.fetchingGroups()) {
    if (!config.testing) fetchGroups(inital: true);
  }

  Future<void> fetchGroups({bool inital = false}) async {
    final userId = await _localUserService.getLoggedInUserId();

    final groupsReq = GQueryAllGroupsConditionalJoinTokenReq((b) => b
      ..fetchPolicy = inital ? FetchPolicy.NetworkOnly : FetchPolicy.CacheOnly
      ..vars.self_id = userId);

    GQueryAllGroupsConditionalJoinTokenData groupsData;
    try {
      groupsData = await _gqlClient.request(groupsReq);
    } on Failure catch (f) {
      emit(UpdateGroupsState.failure(f));
      return;
    }

    final Map<UuidType, GroupsPageGroup> groups = {};
    for (final adminGroup in groupsData.admin_groups) {
      String? joinToken;

      if (adminGroup.group.group_join_tokens.isNotEmpty) {
        joinToken = adminGroup.group.group_join_tokens.first.join_token;
      }

      groups[adminGroup.group.id] = GroupsPageGroup(
          group: Group(
              admin: true,
              id: adminGroup.group.id,
              name: adminGroup.group.group_name),
          joinTokenState: JoinTokenState.adminWithToken(joinToken),
          leaveState: LeavingState.notLeaving());
    }

    for (final memberGroup in groupsData.member_groups) {
      groups[memberGroup.group.id] = GroupsPageGroup(
          leaveState: LeavingState.notLeaving(),
          joinTokenState: JoinTokenState.notAdmin(),
          group: Group(
              admin: false,
              id: memberGroup.group.id,
              name: memberGroup.group.group_name));
    }

    emit(UpdateGroupsState.fetched(groups));
  }

  Future<void> updateGroupJoinToken(UuidType groupId,
      {bool delete = false}) async {
    final token = delete ? null : generateRandomString(10);

    _updateSingleGroup(groupId, joinTokenState: JoinTokenState.adminLoading());

    try {
      await _gqlClient.request(GUpsertGroupJoinTokenReq((q) => q
        ..vars.group_id = groupId
        ..vars.new_token = token));
    } on Failure catch (f) {
      emit(UpdateGroupsState.failure(f));
      return;
    }

    _updateSingleGroup(groupId,
        joinTokenState: JoinTokenState.adminWithToken(token));
  }

  Future<void> leaveGroup(UuidType groupId, VoidCallback onComplete) async {
    _updateSingleGroup(groupId,
        leaveState: LeavingState.prompting(
            accepted: () => _leaveGroupForReal(groupId, onComplete),
            rejected: () => _updateSingleGroup(groupId,
                leaveState: LeavingState.notLeaving())));
  }

  Future<void> _leaveGroupForReal(
      UuidType groupId, void Function() onComplete) async {
    _updateSingleGroup(groupId, leaveState: LeavingState.leaving());

    final userId = await _localUserService.getLoggedInUserId();

    try {
      await _gqlClient.request(GRemoveSelfFromGroupReq((q) => q
        ..vars.groupId = groupId
        ..vars.userId = userId));
    } on Failure catch (f) {
      _updateSingleGroup(groupId, leaveState: LeavingState.failure(f));
      return;
    }

    _gqlClient.cache.evict('groups:$groupId');
    _gqlClient.cache.gc();
    onComplete();
    _updateSingleGroup(groupId, remove: true);
  }

  void _updateSingleGroup(UuidType groupId,
      {LeavingState? leaveState,
      JoinTokenState? joinTokenState,
      bool remove = false}) {
    assert(leaveState != null || joinTokenState != null || remove,
        'updating no state');

    final currState = state.join((_) => null, (fgs) => fgs, (_) => null);

    if (currState == null) {
      throw Exception('cannot update groups without having fetched them');
    }

    final updatingGroup = currState.groups[groupId]!;

    final Map<UuidType, GroupsPageGroup> newGroups = {};
    newGroups.addAll(currState.groups);

    if (!remove) {
      newGroups[groupId] = GroupsPageGroup(
          group: updatingGroup.group,
          joinTokenState: joinTokenState ?? updatingGroup.joinTokenState,
          leaveState: leaveState ?? updatingGroup.leaveState);
    } else {
      newGroups.remove(groupId);
    }

    emit(UpdateGroupsState.fetched(newGroups));
  }
}
