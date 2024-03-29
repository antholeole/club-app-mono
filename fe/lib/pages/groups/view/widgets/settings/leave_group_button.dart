import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/remove_self_from_group.data.gql.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';
import 'package:fe/gql/remove_self_from_group.var.gql.dart';

import '../../../../../service_locator.dart';

class LeaveGroupButton extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();

  @visibleForTesting
  static const String LEAVE_GROUP = 'leave group';

  LeaveGroupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return LoadableTileButton(
      text: LeaveGroupButton.LEAVE_GROUP,
      onClick: () => context.read<ToasterCubit>().add(Toast(
          type: ToastType.Warning,
          message: "Are you sure you'd like to leave ${group.name}?",
          expire: false,
          action: ToastAction(
              action: () => _leaveGroup(group, context),
              actionText: 'Leave Group'))),
      color: Colors.red,
    );
  }

  Future<void> _leaveGroup(Club group, BuildContext context) async {
    try {
      await _gqlClient
          .request<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
              GRemoveSelfFromGroupReq((q) => q
                ..vars.groupId = group.id
                ..vars.userId = context.read<UserCubit>().user.id
                ..fetchPolicy = FetchPolicy.NetworkOnly))
          .first;
      context.read<ToasterCubit>().add(
          Toast(type: ToastType.Success, message: 'Left group ${group.name}'));
      context.read<GroupReqCubit>().refresh();
      await context.read<MainCubit>().initalizeMainPage();
    } on Failure catch (f) {
      getIt<Handler>().handleFailure(f, context);
    }
  }
}
