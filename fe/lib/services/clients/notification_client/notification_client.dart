import 'package:fe/data/models/notification_data.dart';
import 'package:fe/services/clients/notification_client/notification_handler.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service_locator.dart';
import '../gql_client/auth_gql_client.dart';
import 'package:fe/gql/manage_device_token.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show GDeviceTokenHandleType;

Future<void> notificationClientBackgroundMessageInvoker(
    RemoteMessage message) async {
  final notificationClient = NotificationClient();
  await notificationClient._handleNotification(message);
}

class NotificationClient {
  static const REGISTERED_DEVICE_TOKEN_KEY = 'registered_device_token';

  final _authGqlClient = getIt<AuthGqlClient>();
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _firebaseMessaging = getIt<FirebaseMessaging>();
  final _notificationHandler = getIt<NotificationHandler>();
  final _handler = getIt<Handler>();

  NotificationClient() {
    _beginForegroundListen();
    _firebaseMessaging.onTokenRefresh.listen(ensureRegisteredDeviceToken);
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

  Future<void> _handleNotification(RemoteMessage message) async {
    try {
      final notification = NotificationData.fromJson(message.data);
      await _notificationHandler.handle(notification);
    } on Exception catch (e) {
      await _handler.reportUnknown(
          e, 'error while handling notification: ${message.data.toString()}');
      return;
    }
  }

  void _beginForegroundListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleNotification(message);
    });
  }
}
