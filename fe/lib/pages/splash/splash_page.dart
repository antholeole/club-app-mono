import 'package:fe/pages/splash/features/app_boot/app_boot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/app_boot/cubit/splash_cubit.dart';
import 'features/app_boot/widgets/splash.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashCubit(),
        child: const AppBoot(child: Splash()));
  }
}
