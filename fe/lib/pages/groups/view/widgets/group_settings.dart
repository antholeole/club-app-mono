import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  @visibleForTesting
  static const String JOIN_TOKEN_HEADER = 'Join Token';

  @visibleForTesting
  static const String NO_JOIN_TOKEN_TEXT = 'No Join Token.';

  @visibleForTesting
  static const String ERROR_LOADING_USERS = 'Error loading members';

  @visibleForTesting
  static const String LEAVE_GROUP = 'leave group';

  final GroupsPageGroup _group;

  const GroupSettings({required GroupsPageGroup group}) : _group = group;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateGroupsCubit, UpdateGroupsState>(
      listener: (context, state) => state.join((_) => null,
          (fgs) => _onUpdateJoinTokenState(fgs, context), (_) => null),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildUsers(),
          if (_group.group.admin)
            ..._buildJoinToken(
              context,
            ),
          LoadableTileButton(
            text: GroupSettings.LEAVE_GROUP,
            onClick: () => context.read<UpdateGroupsCubit>().leaveGroup(
                _group.group.id,
                () => context.read<ToasterCubit>().add(Toast(
                    type: ToastType.Success,
                    message: 'Left group ${_group.group.name}'))),
            color: Colors.red,
            loading: _group.leaveState == LeavingState.leaving(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUsers() {
    return [
      const TileHeader(text: 'Members'),
      GqlOperation(
          operationRequest: GQueryUsersInGroupReq(
            (b) => b
              ..fetchPolicy = FetchPolicy.NetworkOnly
              ..vars.groupId = _group.group.id,
          ),
          errorText: GroupSettings.ERROR_LOADING_USERS,
          onResponse: (GQueryUsersInGroupData data) => Column(
                  children: data.user_to_group.map((user) {
                return _buildUserTile(user);
              }).toList())),
    ];
  }

  Widget _buildUserTile(GQueryUsersInGroupData_user_to_group userData) {
    return Tile(
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserAvatar(
            name: userData.user.name,
            profileUrl: userData.user.profile_picture,
          ),
        ),
        Text(userData.user.name)
      ]),
    );
  }

  List<Widget> _buildJoinToken(BuildContext context) {
    return [
      const TileHeader(
        text: GroupSettings.JOIN_TOKEN_HEADER,
      ),
      _group.joinTokenState.join(
          (_) => throw Exception('not admin but building join token'),
          (_) => const Loader(size: 12),
          (awt) => _buildJoinTokenTile(context, awt.token))
    ];
  }

  Widget _buildJoinTokenTile(BuildContext context, String? joinToken) {
    final update = (bool delete) => context
        .read<UpdateGroupsCubit>()
        .updateGroupJoinToken(_group.group.id, delete: delete);

    return Tile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(joinToken ?? GroupSettings.NO_JOIN_TOKEN_TEXT),
            Row(
              children: [
                GestureDetector(
                  onTap: () => update(false),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.blue.shade300,
                  ),
                ),
                GestureDetector(
                  onTap: () => update(true),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onUpdateJoinTokenState(FetchedGroupsState fgs, BuildContext context) {
    fgs.groups[_group.group.id]?.leaveState.join((_) => null, (_) => null,
        (pls) {
      context.read<ToasterCubit>().add(Toast(
          type: ToastType.Warning,
          message: "Are you sure you'd like to leave ${_group.group.name}?",
          expire: false,
          onDismiss: pls.rejected,
          action: ToastAction(
              action: () async {
                await pls.accepted();
                await context.read<MainCubit>().initalizeMainPage();
              },
              actionText: 'Leave Group')));
    }, (fls) => handleFailure(fls.failure, context));
  }
}
