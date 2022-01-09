import 'package:fe/stdlib/errors/failure.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';
import 'gql_client/auth_gql_client.dart';
import 'package:fe/gql/manage_device_token.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show GDeviceTokenHandleType;

Future<void> notificationClientBackgroundMessageInvoker(
    RemoteMessage message) async {
  final notificationClient = NotificationClient();
  await notificationClient._handleBackgroundMessage(message);
}

class NotificationClient {
  static const REGISTERED_DEVICE_TOKEN_KEY = 'registered_device_token';

  final _authGqlClient = getIt<AuthGqlClient>();
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _firebaseMessaging = getIt<FirebaseMessaging>();

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

  /// already sent is a convinenence; a duplicate device token
  /// can be sent without harm.
  Future<void> ensureRegisteredDeviceToken([String? newToken]) async {
    final token = await _firebaseMessaging.getToken();
    final alreadySent =
        _sharedPrefrences.getString(REGISTERED_DEVICE_TOKEN_KEY);

    if (alreadySent == token) {
      return;
    }

    await _authGqlClient
        .request(GManageDeviceTokenReq((q) => q
          ..vars.handle = GDeviceTokenHandleType.Add
          ..vars.deviceToken = token))
        .first;

    await _sharedPrefrences.setString(REGISTERED_DEVICE_TOKEN_KEY, token!);
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message');
  }

  void _beginForegroundListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
