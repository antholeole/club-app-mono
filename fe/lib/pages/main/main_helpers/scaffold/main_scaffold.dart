import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/chat/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/scaffold_cubit.dart'
    as sc;
import 'package:fe/pages/main/main_helpers/scaffold/scaffold_button.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'drawers/left_drawer/club_drawer.dart';

class MainScaffold extends StatelessWidget {
  final Widget _child;

  MainScaffold({
    Key? key,
    required Widget child,
  }) : _child = child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<sc.ScaffoldCubit, sc.ScaffoldState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backwardsCompatibility: false,
            backgroundColor: Color(0xffFBFBFB),
            foregroundColor: Colors.grey[900],
            automaticallyImplyLeading: false,
            title: _buildTitle(state.mainScaffoldParts.titleBarWidget),
            leading: ScaffoldButton(
                icon: Icons.menu,
                onPressed: (sbContext) => Scaffold.of(sbContext).openDrawer()),
            actions:
                _buildContextButtons(state.mainScaffoldParts.actionButtons),
          ),
          drawer: ClubDrawer(),
          endDrawer: state.mainScaffoldParts.endDrawer,
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
      },
    );
  }

  List<Widget> _buildContextButtons(List<ActionButton> actionButtons) {
    if (actionButtons.isEmpty) {
      return [
        Container(),
      ];
    }

    return actionButtons
        .map((actionButton) => ScaffoldButton(
            icon: actionButton.icon, onPressed: (_) => actionButton.onClick()))
        .toList();
  }

  Widget _buildTitle(Widget? titleBarWidget) {
    return BlocBuilder<MainPageBloc, MainPageState>(builder: (context, state) {
      if (state is MainPageGroupless) {
        return Text('No group selected',
            style: Theme.of(context).textTheme.caption);
      } else if (state is MainPageWithGroup) {
        final subheader = Text(
          state.group.name,
          style: Theme.of(context).textTheme.caption,
        );

        if (titleBarWidget != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleBarWidget,
              subheader,
            ],
          );
        } else {
          return subheader;
        }
      } else {
        return Container();
      }
    });
  }

  void _changeTab(int tab, bool held, BuildContext scaffoldContext) {
    //if held tab 0 or double tapped, open bottom sheet
    if ((tab == 0 && held) ||
        (tab == 0 &&
            scaffoldContext.read<PageCubit>().state.currentPage == tab)) {
      ChannelsBottomSheet.show(scaffoldContext);
    } else {
      scaffoldContext.read<PageCubit>().setPage(tab);
    }
  }
}
