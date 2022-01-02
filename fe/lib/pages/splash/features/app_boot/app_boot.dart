import 'package:fe/flows/app_state.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

class AppBoot extends StatelessWidget {
  final Widget _child;

  const AppBoot({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        child: _child,
        listener: (context, state) => state.when(
              initial: () => context
                  .flow<AppState>()
                  .update((_) => const AppState.needLogin()),
              notLoggedIn: () => context
                  .flow<AppState>()
                  .update((_) => const AppState.needLogin()),
              loggedIn: (user) => context
                  .flow<AppState>()
                  .update((_) => AppState.loggedIn(user)),
            ));
  }
}
