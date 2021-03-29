import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/login/login_page.dart';
import 'package:fe/pages/main/chat/chat_page.dart';
import 'package:fe/pages/main/events/events_page.dart';
import 'package:fe/pages/main/main_helpers/main_wrapper.dart';
import 'package:fe/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    NoAnimationRoute(path: '/', page: SplashScreen, initial: true),
    NoAnimationRoute(path: '/login', page: LoginPage),
    NoAnimationRoute(
        path: '/main',
        name: 'main',
        usesTabsRouter: true,
        page: MainWrapper,
        children: [
          NoAnimationRoute(path: 'events', page: EventsPage),
          NoAnimationRoute(path: 'chat', page: ChatPage)
        ])
  ],
)
class $AppRouter {}

class NoAnimationRoute<T> extends CustomRoute<T> {
  const NoAnimationRoute({
    bool initial = false,
    bool fullscreenDialog = false,
    bool maintainState = true,
    String? name,
    String? path,
    bool fullMatch = false,
    required Type page,
    List<Type>? guards,
    bool usesTabsRouter = false,
    List<AutoRoute>? children,
  }) : super(
            initial: initial,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            path: path,
            name: name,
            usesTabsRouter: usesTabsRouter,
            fullMatch: fullMatch,
            page: page,
            durationInMilliseconds: 0,
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: invisAnimation,
            guards: guards,
            children: children);

  static Widget invisAnimation(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
