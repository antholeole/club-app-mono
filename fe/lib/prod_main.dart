import 'package:fe/main.dart';
import 'package:fe/service_locator.dart';
import 'package:flutter/cupertino.dart';

Future<void> main() async {
  await asyncStartup();
  setupLocator(isProd: true);
  runApp(MyApp());
}
