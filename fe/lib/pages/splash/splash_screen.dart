import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/splash/splash_service.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashService _splashService = getIt<SplashService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Logo(
          filled: true,
        ),
      ),
    );
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
    final userExists = await _splashService.loadPreExistingUserFromMemory();
    if (userExists) {
      await AutoRouter.of(context).popAndPush(Main());
    } else {
      await AutoRouter.of(context).popAndPush(LoginRoute());
    }
  }
}
