import 'package:fe/pages/main/cubit/main_cubit.dart';

import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart' as sc;
import 'package:fe/pages/scaffold/view/widgets/drawers/left_drawer/club_drawer.dart';
import 'package:fe/pages/scaffold/view/widgets/scaffold_button.dart';
import 'package:fe/pages/scaffold/view/widgets/bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  final Widget _child;

  const MainScaffold({
    Key? key,
    required Widget child,
  }) : _child = child;

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    final mainScaffoldParts =
        context.watch<sc.ScaffoldCubit>().state.mainScaffoldParts;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffFBFBFB),
          foregroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: _buildTitle(mainScaffoldParts.titleBarWidget),
          leading: ScaffoldButton(
              icon: Icons.menu,
              onPressed: (sbContext) => Scaffold.of(sbContext).openDrawer()),
          actions: _buildContextButtons(mainScaffoldParts.actionButtons),
        ),
        drawer: ClubDrawer(),
        endDrawer: mainScaffoldParts.endDrawer,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: widget._child,
        ),
        bottomNavigationBar: _buildBottomNav(context.watch<MainCubit>()));
  }

  Widget? _buildBottomNav(MainCubit cubit) {
    return cubit.state.join((_) => null, (_) => null, (_) => null,
        (p0) => const BottomNav(), (_) => null, (_) => null);
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
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) => state.join(
          (_) => Container(),
          (_) => Container(),
          (_) => Text('No group selected',
              style: Theme.of(context).textTheme.caption),
          (mpwg) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (titleBarWidget != null) titleBarWidget,
                  Text(
                    mpwg.club.name,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
          (_) => Container(),
          (mpwdm) => titleBarWidget!),
    );
  }
}
