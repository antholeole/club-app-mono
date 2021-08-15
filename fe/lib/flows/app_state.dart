import 'package:equatable/equatable.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/login/view/login_page.dart';
import 'package:fe/pages/main/view/main_page.dart';
import 'package:fe/pages/splash/view/splash_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sealed_unions/factories/triplet_factory.dart';
import 'package:sealed_unions/implementations/union_3_impl.dart';
import 'package:sealed_unions/union_3.dart';

import '../service_locator.dart';

@immutable
class AppState extends Union3Impl<_Loading, _LoggedIn, _NeedLogin> {
  static const Triplet<_Loading, _LoggedIn, _NeedLogin> _factory =
      Triplet<_Loading, _LoggedIn, _NeedLogin>();

  AppState._(
    Union3<_Loading, _LoggedIn, _NeedLogin> union,
  ) : super(union);

  factory AppState.loading() => AppState._(_factory.first(_Loading()));

  factory AppState.loggedIn(User user) =>
      AppState._(_factory.second(_LoggedIn(user: user)));

  factory AppState.needLogIn() => AppState._(_factory.third(_NeedLogin()));

  static FlowBuilder<AppState> getFlow(BuildContext context) {
    return FlowBuilder<AppState>(
        controller: getIt<FlowController<AppState>>(),
        onGeneratePages: (currentState, _) {
          final List<Page> pages = [];

          pages.add(currentState.join(
              (_) => platformPage(
                    context: context,
                    title: 'splash',
                    child: const SplashPage(),
                  ),
              (loggedIn) => platformPage(
                    context: context,
                    title: 'main',
                    child: MainPage(user: loggedIn.user),
                  ),
              (_) => platformPage(
                  context: context, title: 'login', child: LoginPage())));

          return pages;
        });
  }
}

@immutable
class _Loading extends Equatable {
  @override
  List<Object?> get props => [];
}

@immutable
class _LoggedIn extends Equatable {
  final User user;

  const _LoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}

@immutable
class _NeedLogin extends Equatable {
  @override
  List<Object?> get props => [];
}
