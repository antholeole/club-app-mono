import 'package:fe/data/models/group.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';
import 'package:fe/gql/upsert_group_join_token.req.gql.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/stdlib/helpers/random_string.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../service_locator.dart';

class GroupsService {
  final _gqlClient = getIt<Client>();
  final _localUser = getIt<LocalUser>();

  void leaveGroup(Group group, BuildContext context, Function() willLeaveGroup,
      void Function() didLeaveGroup) {
    Future<void> leftGroup() async {
      willLeaveGroup();

      final query = GRemoveSelfFromGroupReq((q) => q
        ..vars.groupId = group.id
        ..vars.userId = _localUser.uuid);

      await _gqlClient.request(query).first;

      _gqlClient.cache.evict('groups:${group.id}');
      _gqlClient.cache.gc();

      Toaster.of(context).successToast('Left group ${group.name}');

      final state = context.read<MainPageBloc>().state;

      if (state is MainPageWithGroup && state.group.id == group.id) {
        context.read<MainPageBloc>().add(ResetMainPageEvent());
      }
      didLeaveGroup();
    }

    Toaster.of(context).warningToast(
      "Are you sure you'd like to leave ${group.name}?",
      action: leftGroup,
      actionText: 'Leave Group',
    );
  }

  Future<String?> updateGroupJoinToken(UuidType groupId,
      {bool delete = false}) async {
    final token = delete ? null : generateRandomString(10);

    final query = GUpsertGroupJoinTokenReq((q) => q
      ..vars.group_id = groupId
      ..vars.new_token = token);

    await _gqlClient.request(query).first;

    return token;
  }
}
