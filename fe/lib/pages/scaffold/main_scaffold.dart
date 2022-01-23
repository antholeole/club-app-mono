import 'package:badges/badges.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/scaffold/features/club_drawer/club_drawer.dart';
import 'package:fe/pages/scaffold/features/bottom_nav/bottom_nav.dart';
import 'package:fe/pages/scaffold/features/scaffold_title/scaffold_title.dart';
import 'package:fe/pages/scaffold/widgets/scaffold_button.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/shared_widgets/notification_container_listener.dart';
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
          title: ScaffoldTitle(
            titleBarWidget: _titleBarWidget,
          ),
          leading: NotificationContainerListener(
            path: const AllChatsNotificationPath(),
            builder: (notifs) => Badge(
              position: BadgePosition.topEnd(top: 13, end: 12),
              showBadge: notifs != null && notifs.isNotEmpty,
              child: ScaffoldButton(
                  icon: Icons.menu,
                  onPressed: (sbContext) =>
                      Scaffold.of(sbContext).openDrawer()),
            ),
          ),
          actions: _actionButtons,
        ),
        drawer: ClubsDrawer(),
        endDrawer: _endDrawer,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: _child,
        ),
        bottomNavigationBar: context
            .watch<Group?>()
            ?.map(dm: (_) => null, club: (club) => const BottomNav()));
  }
}
