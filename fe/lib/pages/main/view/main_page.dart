import 'dart:convert';

import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/chat_page.dart';
import 'package:fe/pages/events/events_page.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/main/view/widgets/group_joiner.dart';
import 'package:fe/pages/main/view/widgets/join_group_button.dart';
import 'package:fe/pages/main/view/widgets/log_outer.dart';
import 'package:fe/pages/scaffold/cubit/chat_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_state.dart';
import 'package:fe/pages/scaffold/view/main_scaffold.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const String RETRY_COPY = 'Sorry, there seems to be an error. Retry?';
  static const String GROUPLESS_COPY =
      "Seems like you're not in any clubs... Maybe you should join one?";

  final User _user;
  final PageController _pageController = PageController(initialPage: 0);

  MainPage({required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageCubit()),
        BlocProvider(create: (_) => ChatBottomSheetCubit()),
        BlocProvider(create: (_) => UserCubit(_user)),
      ],
      child: LogOutRunner(
        child: GroupJoinDisplay(
          child: BlocListener<PageCubit, PageState>(
            listener: (context, state) =>
                _pageController.jumpToPage(state.index),
            child: HydratedBuilder<Group>('current_group',
                onBuild: (context, group) {
                  return _buildContent(context);
                },
                onEmpty: (context) => MainScaffold(child: _buildGroupless()),
                serialize: (group) => json.encode(group.toJson()),
                deserialize: (group) => Group.fromJson(json.decode(group))),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [const ChatPage(), const EventsPage()],
    );
  }

  Widget _buildGroupless() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              GROUPLESS_COPY,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        JoinGroupButton(),
      ],
    ));
  }
}
