import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_view_only_threads.data.gql.dart';
import 'package:fe/gql/query_view_only_threads.req.gql.dart';
import 'package:fe/gql/query_view_only_threads.var.gql.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/scaffold/cubit/chat_bottom_sheet_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fe/gql/add_thread_to_group.req.gql.dart';
import 'package:fe/gql/add_thread_to_group.var.gql.dart';
import 'package:fe/gql/add_thread_to_group.data.gql.dart';

import '../../../../../service_locator.dart';

class ChannelsBottomSheet extends StatelessWidget {
  static const String ERROR_TEXT = 'Error loading threads';
  static const String CHANNELS_TEXT = 'CHANNELS';
  static const String VIEW_ONLY_TEXT = 'VIEW ONLY CHANNELS';
  static const String NO_GROUP = 'No group selected!';
  static const String NO_THREADS = "You're not in any threads yet!";

  final AuthGqlClient _authGqlClient = getIt<AuthGqlClient>();

  @visibleForTesting
  final Thread? selectedThread;
  final BuildContext _providerReadableContext;

  static Future<Thread?> show(BuildContext context,
      {Thread? selectedThread}) async {
    // ignore: unawaited_futures
    HapticFeedback.mediumImpact();

    context.read<ChatBottomSheetCubit>().setState(true);

    final thread = await showModalBottomSheet<Thread?>(
        context: context,
        builder: (_) => ChannelsBottomSheet(
              selectedThread: selectedThread,
              providerReadableContext: context,
            ));

    //in cases where the logout is forced by the bottom sheet,
    //this will fail and thus needs to be nullable.
    context.read<ChatBottomSheetCubit?>()?.setState(false);

    return thread;
  }

  ChannelsBottomSheet(
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
              ? Column(
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    _buildThreadGroup<GQuerySelfThreadsInGroupData,
                            GQuerySelfThreadsInGroupVars>(
                        addable: club.admin,
                        context: context,
                        title: ChannelsBottomSheet.CHANNELS_TEXT,
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
                      _buildThreadGroup<GQueryViewOnlyThreadsData,
                              GQueryViewOnlyThreadsVars>(
                          addable: false,
                          context: context,
                          title: ChannelsBottomSheet.VIEW_ONLY_TEXT,
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
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child:
                      const Center(child: Text(ChannelsBottomSheet.NO_GROUP))),
        ),
      ),
    );
  }

  Widget _buildThreadGroup<TData, TVars>(
      {required BuildContext context,
      required UuidType currentGroupId,
      required Iterable<Thread> Function(TData) dataMap,
      required OperationRequest<TData, TVars> operationRequest,
      required bool addable,
      required String title}) {
    return Expanded(
        child: ListView(
      children: [
        Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'IBM Plex Mono', color: Colors.grey.shade700),
            ),
            if (addable)
              GestureDetector(
                  onTap: () => _addThread(context, currentGroupId),
                  child: const Icon(Icons.add, color: Colors.grey))
          ],
        ),
        GqlOperation<TData, TVars>(
            providerReadableContext: _providerReadableContext,
            operationRequest: operationRequest,
            errorText: ChannelsBottomSheet.ERROR_TEXT,
            onResponse: (TData data) {
              final threads = dataMap(data);

              if (threads.isNotEmpty) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: threads
                        .map((v) => Thread(
                            name: v.name, id: v.id, isViewOnly: v.isViewOnly))
                        .map((v) => _buildChannelTile(
                            viewOnly: v.isViewOnly,
                            unreadMessages: 2,
                            onTap: () => _selectThread(v, context),
                            selected: v == selectedThread,
                            title: v.name))
                        .toList());
              } else {
                return Container(
                  child:
                      const Center(child: Text(ChannelsBottomSheet.NO_THREADS)),
                );
              }
            })
      ],
    ));
  }

  Widget _buildChannelTile(
      {required int unreadMessages,
      required bool selected,
      required String title,
      required Function() onTap,
      required bool viewOnly}) {
    final textColor = viewOnly ? Colors.grey.shade500 : Colors.black;

    return Container(
      decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
          onTap: onTap,
          title: Text(title,
              style: TextStyle(
                  color: textColor,
                  fontWeight: unreadMessages != 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          leading: Text('#',
              style: TextStyle(
                  fontSize: 28,
                  color: textColor,
                  fontWeight: unreadMessages > 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          trailing: (unreadMessages > 0)
              ? Chip(
                  backgroundColor: Colors.red,
                  label: Text(
                    unreadMessages.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : null),
    );
  }

  Future<void> _addThread(BuildContext context, UuidType clubId) async {
    final TextEditingController textEditingController = TextEditingController();

    await showPlatformDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) => PlatformAlertDialog(
              title: const Text('Enter the new thread\'s name'),
              content: PlatformTextField(
                controller: textEditingController,
                hintText: 'New name...',
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  cupertino: (_, __) =>
                      CupertinoDialogActionData(isDestructiveAction: true),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                PlatformDialogAction(
                  onPressed: () => _authGqlClient.mutateFromUi<
                          GAddThreadToGroupData, GAddThreadToGroupVars>(
                      GAddThreadToGroupReq((q) => q
                        ..vars.groupId = clubId
                        ..vars.threadName = textEditingController.text),
                      context, onComplete: (threadData) {
                    Navigator.of(context).pop();
                    _selectThread(
                        Thread(
                            name: threadData.insert_threads_one!.name,
                            isViewOnly: true,
                            id: threadData.insert_threads_one!.id),
                        context);
                  },
                      errorMessage:
                          'failed to add thread ${textEditingController.text}',
                      successMessage:
                          'added thread ${textEditingController.text} - remember to add roles to the thread!'),
                  child: const Text('Create'),
                ),
              ],
            ));
  }

  void _selectThread(Thread v, BuildContext context) {
    Navigator.of(context).pop(v);
  }
}
