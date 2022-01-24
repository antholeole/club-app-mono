import 'package:fe/data/models/notification_data.dart';
import 'package:fe/services/clients/notification_client/notification_handler.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';
import '../../../service_locator.dart';
import '../gql_client/auth_gql_client.dart';
import 'package:fe/gql/manage_device_token.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show GDeviceTokenHandleType;

Future<void> notificationClientBackgroundMessageInvoker(
    RemoteMessage message) async {
  if (!getIt.isRegistered<Config>()) {
    await setupLocator(isProd: false).allReady();
  }

  final notificationClient = NotificationClient();
  await notificationClient._handleNotification(message, inBackground: true);
}

class NotificationClient {
  static const REGISTERED_DEVICE_TOKEN_KEY = 'registered_device_token';

  final _authGqlClient = getIt<AuthGqlClient>();
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _firebaseMessaging = getIt<FirebaseMessaging>();
  final _notificationHandler = getIt<NotificationHandler>();
  final _localNotificationsPlugin = getIt<FlutterLocalNotificationsPlugin>();
  final _handler = getIt<Handler>();

  NotificationClient() {
    _beginForegroundListen();
    _firebaseMessaging.onTokenRefresh.listen(ensureRegisteredDeviceToken);
  }

  static Future<FlutterLocalNotificationsPlugin>
      localNotificationsPlugin() async {
    final plugin = FlutterLocalNotificationsPlugin();

    await plugin.initialize(const InitializationSettings(
        iOS: IOSInitializationSettings(),
        android: AndroidInitializationSettings('app_icon')));

    return plugin;
  }

  Future<void> removeDeviceToken({failSilently = false}) async {
    final token = await _firebaseMessaging.getToken();

    try {
      await _authGqlClient
          .request(GManageDeviceTokenReq((q) => q
            ..vars.handle = GDeviceTokenHandleType.Remove
            ..vars.deviceToken = token))
          .first;
    } on Failure {
      if (!failSilently) {
        rethrow;
      }
    }

    await _sharedPrefrences.remove(REGISTERED_DEVICE_TOKEN_KEY);
  }

  Future<void> ensureRegisteredDeviceToken([String? newToken]) async {
    final token = await _firebaseMessaging.getToken();

    await _authGqlClient
        .request(GManageDeviceTokenReq((q) => q
          ..vars.handle = GDeviceTokenHandleType.Add
          ..vars.deviceToken = token))
        .first;

    await _sharedPrefrences.setString(REGISTERED_DEVICE_TOKEN_KEY, token!);
  }

  Future<void> _handleNotification(RemoteMessage message,
      {required bool inBackground}) async {
    try {
      final notification = await _notificationHandler
          .handle(NotificationData.fromJson(message.data));

      if (notification != null && inBackground) {
        await _localNotificationsPlugin.show(notification.id,
            notification.title, notification.body, notification.details);
      }
    } on Exception catch (e) {
      await _handler.reportUnknown(
          e, 'error while handling notification: ${message.data.toString()}');
      return;
    }
  }

  void _beginForegroundListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleNotification(message, inBackground: false);
    });
  }
}
