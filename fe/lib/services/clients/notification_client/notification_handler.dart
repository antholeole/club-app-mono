import 'package:fe/data/models/notification_data.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/gql/get_new_message_notification_data.req.gql.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class NotificationHandler {
  final _authGqlClient = getIt<AuthGqlClient>();
  final _notificationContainer = getIt<NotificationContainer>();

  Future<PushNotification> handle(NotificationData data) {
    return data.when<Future<PushNotification>>(newMessage: _handleNewMessage);
  }

  Future<PushNotification> _handleNewMessage(UuidType newMessageId) async {
    final res = await _authGqlClient
        .request(GGetNewMessageNotificationDataReq(
            (q) => q..vars.messageId = newMessageId))
        .first;

    NotificationPath path;
    if (res.messages_by_pk?.dm?.id != null) {
      path = DmNotificationPath(dmId: res.messages_by_pk!.dm!.id);
    } else if (res.messages_by_pk?.thread?.id != null) {
      path = ThreadNotificationPath(
          groupId: res.messages_by_pk!.thread!.group.id,
          threadId: res.messages_by_pk!.thread!.id);
    } else {
      throw const Failure(
          status: FailureStatus.Custom,
          customMessage: 'message id not tied to source');
    }

    await _notificationContainer.set(
        path, _notificationContainer.get(path, 0) + 1);

    return PushNotification(body: 'asads', title: 'asdas');
  }
}
