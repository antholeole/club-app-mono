import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/scaffold_button.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:fe/stdlib/theme/loader.dart';
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
        title: _buildTitle(),
        leading: ScaffoldButton(
            icon: Icons.menu,
            onPressed: (sbContext) => Scaffold.of(sbContext).openDrawer()),
        actions: _buildContextButtons(context),
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

  List<Widget> _buildContextButtons(BuildContext context) {
    final currentState = context.watch<MainPageBloc>().state;

    if (currentState is MainPageWithGroup) {
      return [
        ScaffoldButton(
            icon: Icons.group,
            onPressed: (sbContext) => Scaffold.of(sbContext).openEndDrawer())
      ];
    } else {
      return [];
    }
  }

  Widget _buildTitle() {
    return BlocBuilder<MainPageBloc, MainPageState>(builder: (context, state) {
      if (state is MainPageGroupless) {
        return Text('No group selected',
            style: Theme.of(context).textTheme.caption);
      } else if (state is MainPageWithGroup) {
        return Text(
          state.group.name,
          style: Theme.of(context).textTheme.caption,
        );
      } else if (state is MainPageLoading) {
        return Loader(size: 12);
      } else {
        return Container();
      }
    });
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
