import 'package:fe/data/models/notification_data.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/gql/get_new_message_notification_data.req.gql.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fe/schema.schema.gql.dart' show Gmessage_types_enum;

class PushNotification {
  String title;
  int id;
  String body;
  NotificationDetails details;

  PushNotification(
      {required this.title,
      required this.body,
      required this.details,
      required this.id});
}

class NotificationHandler {
  final _authGqlClient = getIt<AuthGqlClient>();
  final _notificationContainer = getIt<NotificationContainer>();

  Future<PushNotification?> handle(NotificationData data) {
    return data.when<Future<PushNotification?>>(newMessage: _handleNewMessage);
  }

  Future<PushNotification?> _handleNewMessage(UuidType newMessageId) async {
    final notificationData = await _authGqlClient
        .request(GGetNewMessageNotificationDataReq(
            (q) => q..vars.messageId = newMessageId))
        .first;

    NotificationPath path;
    PushNotification notification;
    if (notificationData.messages_by_pk?.dm?.id != null) {
      path = DmNotificationPath(dmId: notificationData.messages_by_pk!.dm!.id);

      notification = PushNotification(
          id: newMessageId.uuid.hashCode,
          title: '${notificationData.messages_by_pk!.user.name}',
          body: _generateMessageNotificationText(
              notificationData.messages_by_pk!.message_type,
              notificationData.messages_by_pk!.body),
          details: NotificationDetails(
              iOS: IOSNotificationDetails(
                  threadIdentifier:
                      notificationData.messages_by_pk!.dm!.id.uuid),
              android: AndroidNotificationDetails(
                notificationData.messages_by_pk!.dm!.id.uuid,
                notificationData.messages_by_pk!.dm!.name!,
              )));
    } else if (notificationData.messages_by_pk?.thread?.id != null) {
      path = ThreadNotificationPath(
          groupId: notificationData.messages_by_pk!.thread!.group.id,
          threadId: notificationData.messages_by_pk!.thread!.id);

      notification = PushNotification(
          id: newMessageId.uuid.hashCode,
          title:
              '${notificationData.messages_by_pk!.user.name} (in ${notificationData.messages_by_pk?.thread?.group.name}, #${notificationData.messages_by_pk?.thread?.name})',
          body: _generateMessageNotificationText(
              notificationData.messages_by_pk!.message_type,
              notificationData.messages_by_pk!.body),
          details: NotificationDetails(
              iOS: IOSNotificationDetails(
                  threadIdentifier:
                      notificationData.messages_by_pk!.thread!.id.uuid),
              android: AndroidNotificationDetails(
                notificationData.messages_by_pk!.thread!.id.uuid,
                notificationData.messages_by_pk!.thread!.name,
              )));
    } else {
      throw const Failure(
          status: FailureStatus.Custom,
          customMessage: 'message id not tied to source');
    }

    await _notificationContainer.set(
        path, _notificationContainer.get(path, 0) + 1);

    return notification;
  }

  String _generateMessageNotificationText(
      Gmessage_types_enum type, String body) {
    switch (type) {
      case Gmessage_types_enum.IMAGE:
        return 'Sent an image';
      case Gmessage_types_enum.TEXT:
      default:
        return body;
    }
  }
}
