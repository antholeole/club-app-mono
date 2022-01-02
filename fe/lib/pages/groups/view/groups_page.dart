import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/club_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/dm/dm_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/groups_tab.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/fn_providers/group_joiner.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  id: adminGroup.group!.id,
                  name: adminGroup.group!.name)),
              ...data.member_clubs.map((memberGroup) => Club(
                  admin: false,
                  id: memberGroup.group!.id,
                  name: memberGroup.group!.name))
            ];

            final dms = data.dms
                .map((memberGroup) => Dm(
                    users: memberGroup.user_to_dms
                        .where((user) =>
                            user.user.id != context.read<UserCubit>().user.id)
                        .map((user) => User(
                              name: user.user.name,
                              id: user.user.id,
                            ))
                        .toList(),
                    id: memberGroup.id,
                    dmName: memberGroup.name))
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
                    onAdd: () => context
                        .read<GroupJoiner>()
                        .showPrompt()
                        .then((_) => context.read<GroupReqCubit>().refresh()),
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
