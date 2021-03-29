import 'package:fe/helper_widgets/router.gr.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

void main() async {
  await startup();
  setupLocator(isProd: false);
  runApp(MyApp());
}

Future<void> startup() async {
  await dot_env.load();
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: primaryColor,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser());
  }
}
