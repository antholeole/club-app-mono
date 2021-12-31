import 'package:fe/config.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/theme/club_theme.dart';

import 'package:fe/services/toaster/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  setupLocator(isProd: false);
  await asyncStartup();

  await SentryFlutter.init(
    (options) {
      options.dsn = getIt<Config>().sentryUrl;
      options.tracesSampleRate = 0.2;
      options.environment = getIt<Config>().repr;
    },
    appRunner: () => runApp(ClubApp()),
  );
}

Future<void> asyncStartup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
}

class ClubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club App',
      theme: clubTheme,
      home: AppState.getFlow(context),
      builder: (innerContext, router) => PlatformWidgetBuilder(
          cupertino: (_, child, __) =>
              CupertinoTheme(data: const CupertinoThemeData(), child: child!),
          //need toaster to be able to access overlay
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Toaster(child: router!),
              ),
            ],
          )),
    );
  }
}
