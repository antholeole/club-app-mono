import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/chat/widgets/chat_input/chat_bar.dart';
import 'package:fe/pages/chat/widgets/chat_title.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void didChangeDependencies() {
    if (AutoRouter.of(context).innerRouterOf(Main.name)!.topRoute.name ==
        ChatRoute.name) {
      context
          .read<MainScaffoldCubit>()
          .updateMainScaffold(_mainScaffoldParts());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainPageBloc, MainPageState>(
      listener: (context, state) => context.read<ChatCubit>().setThread(null),
      child: FooterLayout(
        footer: KeyboardAttachable(child: ChatBar()),
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  MainScaffoldUpdate _mainScaffoldParts() {
    return MainScaffoldUpdate(
        actionButtons: [
          ActionButton(
              icon: Icons.ac_unit,
              onClick: () {
                print('hi!');
              }),
          ActionButton(
              icon: Icons.access_alarm_outlined,
              onClick: () {
                print('hi 2!');
              }),
        ],
        endDrawer: Container(
          color: Colors.red,
        ),
        titleBarWidget: GestureDetector(
            onTap: () => ChannelsBottomSheet.show(context),
            child: ChatTitle()));
  }
}
