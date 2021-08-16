import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/groups/view/widgets/group_tab.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';

import 'package:fe/stdlib/theme/loader.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UpdateGroupsCubit()),
      ],
      child: const GroupsView(),
    );
  }
}

class GroupsView extends StatelessWidget {
  @visibleForTesting
  static const ERROR_TEXT = 'sorry, there was an error loading groups.';

  @visibleForTesting
  static const NO_CLUBS_TEXT = 'You have no clubs. Go ahead and join some!';

  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocConsumer<UpdateGroupsCubit, UpdateGroupsState>(
          listener: (context, state) => state.join((_) => null, (_) => null,
              (fgf) => handleFailure(fgf.failure, context)),
          builder: (context, state) => state.join(
              (_) => const Loader(),
              (fgs) => _buildGroups(fgs.groups.values, context),
              (_) => const Center(
                    child: Text(GroupsView.ERROR_TEXT),
                  ))),
    );
  }

  Widget _buildGroups(Iterable<GroupsPageGroup> groups, BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Your Clubs',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      groups.isNotEmpty
          ? Expanded(
              child: ListView(
                  shrinkWrap: true,
                  children: groups
                      .map(
                        (v) => GroupTab(
                          group: v,
                        ),
                      )
                      .toList()),
            )
          : Expanded(
              child: Center(
                  child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                GroupsView.NO_CLUBS_TEXT,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            )))
    ]);
  }
}
