import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadger {
  Future<void> set(int notificationNumber) async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.updateBadgeCount(notificationNumber);
    }
  }
}
