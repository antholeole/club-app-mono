import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/helpers/channels_bottom_sheet.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/scaffold_button.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'drawers/left_drawer/club_drawer.dart';
import 'drawers/right_drawer/group_drawer.dart';

class MainScaffold extends StatelessWidget {
  final Widget _child;

  const MainScaffold({
    Key? key,
    required Widget child,
  }) : _child = child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Color(0xffFBFBFB),
        foregroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
        title: Column(
          children: _buildTitle(context),
        ),
        leading: ScaffoldButton(
            icon: Icons.menu,
            onPressed: (sbContext) => Scaffold.of(sbContext).openDrawer()),
        actions:
            context.read<MainPageActionsCubit>().state.selectedGroup != null
                ? [
                    ScaffoldButton(
                      icon: Icons.group,
                      onPressed: (sbContext) =>
                          Scaffold.of(sbContext).openEndDrawer(),
                    )
                  ]
                : [],
      ),
      drawer: ClubDrawer(),
      endDrawer: GroupDrawer(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _child,
      ),
      bottomNavigationBar: BottomNav(
          onClickTab: (to, held) => _changeTab(to, held, context),
          icons: [Icons.chat_bubble_outline, Icons.event]),
    );
  }

  List<Widget> _buildTitle(BuildContext context) {
    final titleElements = <Widget>[];

    final actionCubit = context.read<MainPageActionsCubit>();

    if (actionCubit.state.selectedGroup != null) {
      {
        titleElements.add(Text(
          actionCubit.state.selectedGroup!.name,
          style: Theme.of(context).textTheme.caption,
        ));
      }
    }

    return titleElements;
  }

  void _changeTab(int tab, bool held, BuildContext context) {
    if (tab == 0 && held) {
      HapticFeedback.mediumImpact();
      showModalBottomSheet(
          context: context,
          builder: (_) => ChannelsBottomSheet(
                providerReadableContext: context,
              ));
    } else {
      AutoRouter.of(context)
          .innerRouterOf<TabsRouter>(Main.name)!
          .setActiveIndex(tab);
    }
  }
}
