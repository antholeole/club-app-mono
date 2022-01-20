import 'package:fe/services/clients/notification_client/notification_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../service_locator.dart';

class NotificationPermissionRequester extends StatelessWidget {
  final Widget _child;

  final _firebaseMessaging = getIt<FirebaseMessaging>();
  final _notificationClient = getIt<NotificationClient>();

  NotificationPermissionRequester({Key? key, required Widget child})
      : _child = child,
        super(key: key) {
    _notificationClient.ensureRegisteredDeviceToken();
    _determineNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  Future<void> _determineNotifications() async {
    final notificationsSettings =
        await _firebaseMessaging.getNotificationSettings();

    switch (notificationsSettings.authorizationStatus) {
      case AuthorizationStatus.notDetermined:
        await _requestNotifications();
        break;
      default:
        break;
    }
  }

  Future<void> _requestNotifications() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        announcement: false,
        carPlay: true,
        sound: true,
        provisional: true);
  }
}
