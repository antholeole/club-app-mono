import 'package:fe/data/models/group.dart';
import 'package:fe/pages/scaffold/view/widgets/drawers/left_drawer/club_drawer.dart';
import 'package:fe/pages/scaffold/view/widgets/scaffold_button.dart';
import 'package:fe/pages/scaffold/view/widgets/bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget _child;
  final Widget? _titleBarWidget;
  final Widget? _endDrawer;
  final List<ScaffoldButton>? _actionButtons;

  const MainScaffold({
    Key? key,
    Widget? titleBarWidget,
    Widget? endDrawer,
    List<ScaffoldButton>? actionButtons,
    required Widget child,
  })  : _titleBarWidget = titleBarWidget,
        _actionButtons = actionButtons,
        _endDrawer = endDrawer,
        _child = child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffFBFBFB),
          foregroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: _buildTitle(_titleBarWidget, context),
          leading: ScaffoldButton(
              icon: Icons.menu,
              onPressed: (sbContext) => Scaffold.of(sbContext).openDrawer()),
          actions: _actionButtons,
        ),
        drawer: ClubsDrawer(),
        endDrawer: _endDrawer,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: _child,
        ),
        bottomNavigationBar:
            context.watch<Group?>() != null ? const BottomNav() : null);
  }

  Widget _buildTitle(Widget? titleBarWidget, BuildContext context) {
    final Group? group = context.watch<Group?>();

    if (group == null) {
      return Text('No group selected',
          style: Theme.of(context).textTheme.caption);
    } else {
      return group.map(
          dm: (dm) => titleBarWidget!,
          club: (club) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (titleBarWidget != null) titleBarWidget,
                  Text(
                    club.name,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ));
    }
  }
}
