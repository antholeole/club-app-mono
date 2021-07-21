import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/splash/spash_helpers/spash_page.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashService _splashService = getIt<SplashService>();

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashService.beginLoadingImagesFromLoginPage(context);
  }

  @override
  void initState() {
    _beginLoadingUserFromMemory();
    super.initState();
  }

  void _beginLoadingUserFromMemory() async {
    final user = await _splashService.loadPreExistingUserFromMemory();

    await _splashService.essentialLoadsFuture();
    if (user != null) {
      await AutoRouter.of(context).popAndPush(const Main());
    } else {
      await AutoRouter.of(context).popAndPush(const LoginRoute());
    }
  }
}
