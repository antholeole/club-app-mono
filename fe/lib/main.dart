import 'package:fe/flows/app_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/theme/colors.dart';
import 'package:fe/services/toaster/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async {
  setupLocator(isProd: false);
  await asyncStartup();
  runApp(MyApp());
}

Future<void> asyncStartup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          textTheme: const TextTheme(
              caption: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          )),
          primaryColor: primaryColor,
          primarySwatch: Colors.red,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0))),
      home: AppState.getFlow(context),
      builder: (innerContext, router) => PlatformWidgetBuilder(
          cupertino: (_, child, __) => CupertinoTheme(
              data: const CupertinoThemeData(primaryColor: primaryColor),
              child: child!),
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
