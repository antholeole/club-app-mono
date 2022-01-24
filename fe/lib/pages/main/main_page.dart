import 'dart:convert';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/chat_page.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/main/features/groupless/groupless_main.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_cubit.dart';
import 'package:fe/services/fn_providers/notification_permission_requester.dart';
import 'package:fe/pages/scaffold/features/threads_bottom_sheet/cubit/threads_bottom_sheet_cubit.dart';
import 'package:fe/services/fn_providers/group_joiner.dart';
import 'package:fe/services/fn_providers/log_outer.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/main_pager/main_pager.dart';

class MainPage extends StatelessWidget {
  static const String RETRY_COPY = 'Sorry, there seems to be an error. Retry?';

  final User _user;

  const MainPage({required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit(_user)),
      ],
      child: NotificationPermissionRequester(
        child: LogOutRunner(
          child: GroupJoinDisplay(
            child: HydratedBuilder<Group>('current_group',
                onBuild: (_, group) => group.map(
                    dm: (dm) => const ChatPage(),
                    club: (club) => MultiProvider(
                          providers: [
                            BlocProvider(
                                create: (_) => ThreadsBottomSheetCubit()),
                            Provider<Club>.value(value: club),
                            Provider.value(value: PageCubit(club: club))
                          ],
                          child: MainPager(),
                        )),
                onEmpty: (context) => const GrouplessMain(),
                serialize: (group) => json.encode(group.toJson()),
                deserialize: (group) => Group.fromJson(json.decode(group))),
          ),
        ),
      ),
    );
  }
}
