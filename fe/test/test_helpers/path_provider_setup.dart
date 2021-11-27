import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// returns two functions: one to setup testing
/// and one to tear down
List<Future<void> Function()> pathProviderSetup(String folderName) {
  final dir = './dump/$folderName/';

  return [
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      const MethodChannel channel =
          MethodChannel('plugins.flutter.io/path_provider');

      await Directory(dir).create(recursive: true);

      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return dir;
      });
    },
    () async {
      try {
        await Directory('./dump/$folderName').delete(recursive: true);
      } catch (_) {}
    }
  ];
}
