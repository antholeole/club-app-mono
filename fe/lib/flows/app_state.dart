import 'package:fe/data/models/user.dart';
import 'package:fe/pages/login/view/login_page.dart';
import 'package:fe/pages/main/view/main_page.dart';
import 'package:fe/pages/splash/splash_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../service_locator.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.loading() = _Loading;
  const factory AppState.loggedIn(User user) = _LoggedIn;
  const factory AppState.needLogin() = _NeedLogin;

  static FlowBuilder<AppState> getFlow(BuildContext context) {
    return FlowBuilder<AppState>(
        controller: getIt<FlowController<AppState>>(),
        onGeneratePages: (currentState, _) => [
              currentState.map(
                  loading: (_) => platformPage(
                        context: context,
                        title: 'splash',
                        child: SplashPage(),
                      ),
                  loggedIn: (loggedIn) => platformPage(
                        context: context,
                        title: 'main',
                        child: MainPage(user: loggedIn.user),
                      ),
                  needLogin: (_) => platformPage(
                      context: context, title: 'login', child: LoginPage()))
            ]);
  }
}
