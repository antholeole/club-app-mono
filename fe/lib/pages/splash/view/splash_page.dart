import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/splash/cubit/splash_cubit.dart';
import 'package:fe/pages/splash/view/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) => state.join(
          (_) {},
          (_) => context.flow<AppState>().update((_) => AppState.needLogIn()),
          (loggedIn) => context
              .flow<AppState>()
              .update((_) => AppState.loggedIn(loggedIn.user))),
      child: const Splash(),
    );
  }
}
