import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/theme/search_bar.dart';
import 'package:fe/stdlib/widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';

class ChannelsBottomSheet extends StatefulWidget {
  final Group? _selectedGroup;
  final ChatCubit _chatCubit;

  const ChannelsBottomSheet(
      {Group? selectedGroup, required ChatCubit chatCubit})
      : _selectedGroup = selectedGroup,
        _chatCubit = chatCubit;

  @override
  _ChannelsBottomSheetState createState() => _ChannelsBottomSheetState();
}

class _ChannelsBottomSheetState extends State<ChannelsBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _channelSearch = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  final LocalUser _localUser = getIt<LocalUser>();

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  void _prepareAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

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
          child: widget._selectedGroup != null
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
                    SearchBar(
                        controller: _channelSearch,
                        onCancel: _cancelSearch,
                        onClear: _clearSearch,
                        focusNode: _searchFocusNode,
                        animation: _animation,
                        onUpdate: (_) => setState(() {}),
                        text: 'Jump to...'),
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
                            operationRequest:
                                GQuerySelfThreadsInGroupReq((q) => q
                                  ..fetchPolicy = FetchPolicy.CacheAndNetwork
                                  ..vars.groupId = widget._selectedGroup!.id
                                  ..vars.userId = _localUser.uuid),
                            toastErrorPrefix: 'Error loading threads',
                            onResponse: (GQuerySelfThreadsInGroupData data) =>
                                BlocBuilder<ChatCubit, ChatState>(
                                    bloc: widget._chatCubit,
                                    builder: (_, state) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: data.group_threads
                                            .where((v) => v.name
                                                .toLowerCase()
                                                .contains(_channelSearch.text
                                                    .toLowerCase()))
                                            .map((v) => _buildChannelTile(
                                                unreadMessages: 2,
                                                onTap: () => widget._chatCubit
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
    return ListTile(
        onTap: onTap,
        tileColor: selected ? Colors.grey.shade200 : Colors.white,
        title: Text(title,
            style: TextStyle(
                fontWeight:
                    unreadMessages != 0 ? FontWeight.bold : FontWeight.normal)),
        leading: Text('#',
            style: TextStyle(
                fontSize: 28,
                fontWeight:
                    unreadMessages > 0 ? FontWeight.bold : FontWeight.normal)),
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
            : null);
  }

  void _cancelSearch() {
    _channelSearch.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    _channelSearch.clear();
  }
}
