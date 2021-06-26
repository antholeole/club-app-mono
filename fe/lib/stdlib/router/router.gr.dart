// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../pages/chat/chat_page.dart' as _i8;
import '../../pages/login/login_page.dart' as _i5;
import '../../pages/main/events/events_page.dart' as _i7;
import '../../pages/main/main_helpers/main_page_wrapper.dart' as _i6;
import '../../pages/splash/splash_screen.dart' as _i3;
import 'router.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashScreen();
        },
        transitionsBuilder: _i4.NoAnimationRoute.invisAnimation,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false),
    LoginRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.LoginPage();
        },
        transitionsBuilder: _i4.NoAnimationRoute.invisAnimation,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false),
    Main.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.MainPageWrapper();
        },
        transitionsBuilder: _i4.NoAnimationRoute.invisAnimation,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false),
    EventsRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.EventsPage();
        },
        transitionsBuilder: _i4.NoAnimationRoute.invisAnimation,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false),
    ChatRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.ChatPage();
        },
        transitionsBuilder: _i4.NoAnimationRoute.invisAnimation,
        durationInMilliseconds: 0,
        reverseDurationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreen.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(Main.name, path: '/main', children: [
          _i1.RouteConfig(EventsRoute.name, path: 'events'),
          _i1.RouteConfig(ChatRoute.name, path: 'chat')
        ])
      ];
}

class SplashScreen extends _i1.PageRouteInfo {
  const SplashScreen() : super(name, path: '/');

  static const String name = 'SplashScreen';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

class Main extends _i1.PageRouteInfo {
  const Main({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/main', initialChildren: children);

  static const String name = 'Main';
}

class EventsRoute extends _i1.PageRouteInfo {
  const EventsRoute() : super(name, path: 'events');

  static const String name = 'EventsRoute';
}

class ChatRoute extends _i1.PageRouteInfo {
  const ChatRoute() : super(name, path: 'chat');

  static const String name = 'ChatRoute';
}
