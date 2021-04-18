import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/colors.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await startup();
  setupLocator(isProd: false);
  runApp(MyApp());
}

Future<void> startup() async {
  await dot_env.load();
  await Hive.initFlutter();
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
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: (_, router) => PlatformWidgetBuilder(
          cupertino: (_, child, __) => CupertinoTheme(
              data: CupertinoThemeData(primaryColor: primaryColor),
              child: child!),
          child: RefreshContextHack(router!)),
    );
  }
}

//hack to get context to refresh so that the toaster can
//access the Material App. For whatever reason, I can't figure
//out how to do this using a builder...
class RefreshContextHack extends StatelessWidget {
  final Widget child;

  const RefreshContextHack(this.child);

  @override
  Widget build(BuildContext context) {
    return Toaster(context: context, child: child);
  }
}
