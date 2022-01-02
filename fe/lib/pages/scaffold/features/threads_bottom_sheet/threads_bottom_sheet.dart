import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_view_only_threads.data.gql.dart';
import 'package:fe/gql/query_view_only_threads.req.gql.dart';
import 'package:fe/gql/query_view_only_threads.var.gql.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/scaffold/features/threads_bottom_sheet/widgets/thread_group.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'cubit/threads_bottom_sheet_cubit.dart';

class ThreadsBottomSheet extends StatelessWidget {
  static const String CHANNELS_TEXT = 'CHANNELS';
  static const String VIEW_ONLY_TEXT = 'VIEW ONLY CHANNELS';
  static const String NO_GROUP = 'No group selected!';

  @visibleForTesting
  final Thread? selectedThread;
  final BuildContext _providerReadableContext;

  static Future<Thread?> show(BuildContext context,
      {Thread? selectedThread}) async {
    // ignore: unawaited_futures
    HapticFeedback.mediumImpact();

    context.read<ThreadsBottomSheetCubit>().setState(true);

    final thread = await showModalBottomSheet<Thread?>(
        context: context,
        builder: (_) => ThreadsBottomSheet(
              selectedThread: selectedThread,
              providerReadableContext: context,
            ));

    //in cases where the logout is forced by the bottom sheet,
    //this will fail and thus needs to be nullable.
    context.read<ThreadsBottomSheetCubit?>()?.setState(false);

    return thread;
  }

  const ThreadsBottomSheet(
      {this.selectedThread, required BuildContext providerReadableContext})
      : _providerReadableContext = providerReadableContext;

  @override
  Widget build(BuildContext context) {
    final club = _providerReadableContext
        .watch<Group?>()
        ?.maybeMap(orElse: () => null, club: (club) => club);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: club != null
              ? MultiProvider(
                  providers: [
                    Provider<Club>.value(value: club),
                    Provider<ToasterCubit>.value(
                        value: _providerReadableContext.read<ToasterCubit>()),
                  ],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                          ),
                        ),
                      ),
                      ThreadGroup<GQuerySelfThreadsInGroupData,
                              GQuerySelfThreadsInGroupVars>(
                          addable: club.admin,
                          selectedThread: selectedThread,
                          title: ThreadsBottomSheet.CHANNELS_TEXT,
                          currentGroupId: club.id,
                          dataMap: (data) => data.threads.map((threadData) =>
                              Thread(
                                  name: threadData.name,
                                  id: threadData.id,
                                  isViewOnly: false)),
                          operationRequest: GQuerySelfThreadsInGroupReq((q) => q
                            ..vars.groupId = club.id
                            ..vars.userId = _providerReadableContext
                                .read<UserCubit>()
                                .state
                                .id)),
                      if (club.admin)
                        ThreadGroup<GQueryViewOnlyThreadsData,
                                GQueryViewOnlyThreadsVars>(
                            addable: false,
                            title: ThreadsBottomSheet.VIEW_ONLY_TEXT,
                            currentGroupId: club.id,
                            dataMap: (data) => data.threads.map((threadData) =>
                                Thread(
                                    name: threadData.name,
                                    id: threadData.id,
                                    isViewOnly: true)),
                            operationRequest: GQueryViewOnlyThreadsReq((q) => q
                              ..vars.groupId = club.id
                              ..vars.userId = _providerReadableContext
                                  .read<UserCubit>()
                                  .state
                                  .id))
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child:
                      const Center(child: Text(ThreadsBottomSheet.NO_GROUP))),
        ),
      ),
    );
  }
}
