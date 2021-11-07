import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/club_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/dm/dm_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/groups_tab.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupReqCubit(context.read<UserCubit>().user.id),
      child: const GroupsView(),
    );
  }
}

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @visibleForTesting
  static const NO_CLUBS_TEXT = 'You have no clubs. Go ahead and join some!';

  @visibleForTesting
  static const NO_DMS_TEXT = 'No direct messages.';

  @visibleForTesting
  static const ERROR_TEXT = 'sorry, there was an error loading groups.';

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: GqlOperation<GQuerySelfGroupsData, GQuerySelfGroupsVars>(
          operationRequest: context.watch<GroupReqCubit>().state,
          onResponse: (data) {
            final clubs = [
              ...data.admin_clubs.map((adminGroup) => Club(
                  admin: true,
                  id: adminGroup.group.id,
                  joinToken: adminGroup.group.group_join_tokens.isEmpty
                      ? null
                      : adminGroup.group.group_join_tokens.first.join_token,
                  name: adminGroup.group.group_name)),
              ...data.member_clubs.map((memberGroup) => Club(
                  admin: false,
                  id: memberGroup.group.id,
                  name: memberGroup.group.group_name))
            ];

            final dms = data.dms
                .map((memberGroup) => Dm(
                    users: memberGroup.thread.user_to_threads
                        .where((user) =>
                            user.user.id != context.read<UserCubit>().user.id)
                        .map((user) => User(
                            name: user.user.name,
                            id: user.user.id,
                            profilePictureUrl: user.user.profile_picture))
                        .toList(),
                    id: memberGroup.thread.id,
                    name: memberGroup.thread.name))
                .toList();

            return Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: [
                  GroupsTab<Club>(
                    buildTab: () => const ClubTab(),
                    groups: clubs,
                    header: 'Your Clubs',
                    noElementsText: NO_CLUBS_TEXT,
                  ),
                  GroupsTab<Dm>(
                    buildTab: () => const DmTab(),
                    groups: dms,
                    header: 'DMs',
                    noElementsText: NO_DMS_TEXT,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
