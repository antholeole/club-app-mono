// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../../data_classes/chat.dart' as _i9;
import '../../data_classes/local_user.dart' as _i8;
import '../../pages/login/login_page.dart' as _i4;
import '../../pages/main/chat/chat_page.dart' as _i7;
import '../../pages/main/events/events_page.dart' as _i6;
import '../../pages/main/main_helpers/main_wrapper.dart' as _i5;
import '../../pages/splash/splash_screen.dart' as _i2;
import 'router.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreen.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i2.SplashScreen(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    LoginRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i4.LoginPage(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    Main.name: (entry) {
      var args = entry.routeData.argsAs<MainArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i5.MainWrapper(user: args.user),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    EventsRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i6.EventsPage(),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    },
    ChatRoute.name: (entry) {
      var args = entry.routeData.argsAs<ChatRouteArgs>();
      return _i1.CustomPage(
          entry: entry,
          child: _i7.ChatPage(chat: args.chat),
          transitionsBuilder: _i3.NoAnimationRoute.invisAnimation,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 0,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreen.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(Main.name,
            path: '/main',
            usesTabsRouter: true,
            children: [
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

class Main extends _i1.PageRouteInfo<MainArgs> {
  Main({required _i8.LocalUser user, List<_i1.PageRouteInfo>? children})
      : super(name,
            path: '/main',
            args: MainArgs(user: user),
            initialChildren: children);

  static const String name = 'Main';
}

class MainArgs {
  const MainArgs({required this.user});

  final _i8.LocalUser user;
}

class EventsRoute extends _i1.PageRouteInfo {
  const EventsRoute() : super(name, path: 'events');

  static const String name = 'EventsRoute';
}

class ChatRoute extends _i1.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({required _i9.Chat chat})
      : super(name, path: 'chat', args: ChatRouteArgs(chat: chat));

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({required this.chat});

  final _i9.Chat chat;
}
