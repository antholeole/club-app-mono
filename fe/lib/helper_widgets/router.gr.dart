// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../data_classes/local_user.dart' as _i8;
import '../pages/login/login_page.dart' as _i4;
import '../pages/main/chat/chat_page.dart' as _i7;
import '../pages/main/events/events_page.dart' as _i6;
import '../pages/main/main_helpers/main_wrapper.dart' as _i5;
import '../pages/splash/splash_screen.dart' as _i2;
import 'router.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i2.SplashScreen(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    LoginPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i4.LoginPage(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    MainWrapperRoute.name: (entry) {
      var args = entry.routeData.argsAs<MainWrapperRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i5.MainWrapper(user: args.user),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    EventsPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i6.EventsPage(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    ChatPageRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i7.ChatPage(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i1.RouteConfig(MainWrapperRoute.name,
            path: '/main',
            usesTabsRouter: true,
            children: [
              _i1.RouteConfig(EventsPageRoute.name, path: 'events'),
              _i1.RouteConfig(ChatPageRoute.name, path: 'chat')
            ])
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class LoginPageRoute extends _i1.PageRouteInfo {
  const LoginPageRoute() : super(name, path: '/login');

  static const String name = 'LoginPageRoute';
}

class MainWrapperRoute extends _i1.PageRouteInfo<MainWrapperRouteArgs> {
  MainWrapperRoute(
      {required _i8.LocalUser user, List<_i1.PageRouteInfo>? children})
      : super(name,
            path: '/main',
            args: MainWrapperRouteArgs(user: user),
            initialChildren: children);

  static const String name = 'MainWrapperRoute';
}

class MainWrapperRouteArgs {
  const MainWrapperRouteArgs({required this.user});

  final _i8.LocalUser user;
}

class EventsPageRoute extends _i1.PageRouteInfo {
  const EventsPageRoute() : super(name, path: 'events');

  static const String name = 'EventsPageRoute';
}

class ChatPageRoute extends _i1.PageRouteInfo {
  const ChatPageRoute() : super(name, path: 'chat');

  static const String name = 'ChatPageRoute';
}
