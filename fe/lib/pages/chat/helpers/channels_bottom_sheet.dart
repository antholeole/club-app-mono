import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/theme/search_bar.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';

class ChannelsBottomSheet extends StatelessWidget {
  final BuildContext _providerReadableContext;
  final LocalUser _localUser = getIt<LocalUser>();

  ChannelsBottomSheet({required BuildContext providerReadableContext})
      : _providerReadableContext = providerReadableContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _providerReadableContext
                      .read<MainPageActionsCubit>()
                      .state
                      .selectedGroup !=
                  null
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
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Text(
                          'CHANNELS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              color: Colors.grey.shade700),
                        ),
                        GqlOperation(
                            operationRequest: GQuerySelfThreadsInGroupReq((q) =>
                                q
                                  ..fetchPolicy = FetchPolicy.CacheAndNetwork
                                  ..vars.groupId = _providerReadableContext
                                      .read<MainPageActionsCubit>()
                                      .state
                                      .selectedGroup!
                                      .id
                                  ..vars.userId = _localUser.uuid),
                            toastErrorPrefix: 'Error loading threads',
                            onResponse: (GQuerySelfThreadsInGroupData data) =>
                                BlocBuilder<ChatCubit, ChatState>(
                                    bloc: _providerReadableContext
                                        .read<ChatCubit>(),
                                    builder: (_, state) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: data.group_threads
                                            .map((v) => _buildChannelTile(
                                                unreadMessages: 2,
                                                onTap: () =>
                                                    _providerReadableContext
                                                        .read<ChatCubit>()
                                                        .setThread(v.id),
                                                selected:
                                                    state.threadId == v.id,
                                                title: v.name))
                                            .toList(),
                                      );
                                    })),
                      ],
                    ))
                  ],
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(child: Text('No group selected!'))),
        ),
      ),
    );
  }

  Widget _buildChannelTile({
    required int unreadMessages,
    required bool selected,
    required String title,
    required Function() onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
          onTap: onTap,
          title: Text(title,
              style: TextStyle(
                  fontWeight: unreadMessages != 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          leading: Text('#',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: unreadMessages > 0
                      ? FontWeight.bold
                      : FontWeight.normal)),
          trailing: (unreadMessages > 0)
              ? Chip(
                  backgroundColor: Colors.red,
                  label: Text(
                    unreadMessages.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : null),
    );
  }
}
