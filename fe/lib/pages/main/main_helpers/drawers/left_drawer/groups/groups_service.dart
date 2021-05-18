import 'package:fe/gql/fragments/group.req.gql.dart';
import 'package:fe/gql/fragments/join_token.data.gql.dart';
import 'package:fe/gql/fragments/join_token.req.gql.dart';
import 'package:fe/gql/remote/query_am_admin.req.gql.dart';
import 'package:fe/gql/remote/query_group_join_token.req.gql.dart';
import 'package:fe/gql/remote/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/remote/query_self_group_preview.req.gql.dart';
import 'package:fe/gql/remote/query_users_in_group.data.gql.dart';
import 'package:fe/gql/remote/query_users_in_group.req.gql.dart';
import 'package:fe/gql/remote/remove_self_from_group.req.gql.dart';
import 'package:fe/gql/remote/upsert_group_join_token.req.gql.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/helpers/random_string.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../service_locator.dart';
import '../../../../../../stdlib/clients/gql_client.dart';
import '../../../../../../stdlib/helpers/uuid_type.dart';

class GroupsService {
  final _gqlClient = getIt<Client>();
  final _localUser = getIt<LocalUser>();

  GQueryUsersInGroupData getCachedUsersInGroup(UuidType groupId) {
    final usersInGroupReq = GQueryUsersInGroupReq((b) => b
      ..fetchPolicy = FetchPolicy.NetworkOnly
      ..vars.groupId = groupId);

    final reviewFragmentData = _gqlClient.cache.readQuery(usersInGroupReq);

    return reviewFragmentData!;
  }

  Future<GQuerySelfGroupsPreviewData> fetchGroups(
      {required bool remote}) async {
    final groupsReq = GQuerySelfGroupsPreviewReq((b) => b
      ..fetchPolicy = remote ? FetchPolicy.NetworkOnly : FetchPolicy.CacheOnly
      ..vars.self_id = _localUser.uuid);

    final resp = await _gqlClient.request(groupsReq).first;

    if (resp.hasErrors) {
      throw basicGqlErrorHandler(errors: resp.graphqlErrors);
    }

    return resp.data!;
  }

  Future<GQueryUsersInGroupData> fetchUsersInGroup(UuidType groupId) async {
    final usersInGroupReq = GQueryUsersInGroupReq((b) => b
      ..fetchPolicy = FetchPolicy.NetworkOnly
      ..vars.groupId = groupId);

    final resp = await _gqlClient.request(usersInGroupReq).first;

    if (resp.hasErrors) {
      throw basicGqlErrorHandler(errors: resp.graphqlErrors);
    }

    return resp.data!;
  }

  void leaveGroup(UuidType groupId, BuildContext context,
      Function() willLeaveGroup, void Function() didLeaveGroup) {
    final groupReq = GGroupReq((b) => b..idFields = {'id': groupId});
    final groupData = _gqlClient.cache.readFragment(groupReq);

    Future<void> leftGroup() async {
      willLeaveGroup();

      final query = GRemoveSelfFromGroupReq((q) => q
        ..vars.groupId = groupId
        ..vars.userId = _localUser.uuid);

      await _gqlClient.request(query).first;

      _gqlClient.cache.evict(_gqlClient.cache.identify(groupData)!);
      _gqlClient.cache.gc();

      Toaster.of(context).successToast('Left group ${groupData!.group_name}');

      //if the current group we are in in is the selected one, we should reset
      //selected group
      if (context.read<MainPageActionsCubit>().state.selectedGroupId != null &&
          context.read<MainPageActionsCubit>().state.selectedGroupId ==
              groupId) {
        context.read<MainPageActionsCubit>().resetPage();
      }
      didLeaveGroup();
    }

    Toaster.of(context).warningToast(
      "Are you sure you'd like to leave ${groupData!.group_name}?",
      action: leftGroup,
      actionText: 'Leave Group',
    );
  }

  Future<String?> fetchGroupJoinToken(UuidType groupId) async {
    final query = GQueryGroupJoinTokenReq((q) => q..vars.group_id = groupId);

    final resp = await _gqlClient.request(query).first;

    if (resp.data!.group_join_tokens.isEmpty) {
      return null;
    } else {
      return resp.data!.group_join_tokens.first.join_token;
    }
  }

  Future<String?> updateGroupJoinToken(UuidType groupId,
      {bool delete = false}) async {
    final token = delete ? null : generateRandomString(10);

    final query = GUpsertGroupJoinTokenReq((q) => q
      ..vars.group_id = groupId
      ..vars.new_token = token);

    await _gqlClient.request(query).first;

    final joinTokenReq = GJoinTokenReq(
      (b) => b..idFields = {'group_id': groupId},
    );

    final joinTokenData = GJoinTokenData(
      (b) => b..join_token = token,
    );

    _gqlClient.cache.writeFragment(joinTokenReq, joinTokenData);

    return token;
  }

  Future<bool> isAdmin(UuidType groupId) async {
    final query = GQueryAmAdminReq((b) => b
      ..vars.groupId = groupId
      ..vars.selfId = _localUser.uuid);

    final resp = await _gqlClient.request(query).first;

    if (resp.hasErrors) {
      throw basicGqlErrorHandler(errors: resp.graphqlErrors);
    }

    return resp.data!.user_to_group.first.admin;
  }

  String getCachedJoinToken(UuidType groupId) {
    return 'NOT REAL';
  }
}
