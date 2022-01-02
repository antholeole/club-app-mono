import 'package:bloc/bloc.dart';

import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/gql/insert_message.req.gql.dart';
import 'package:fe/schema.schema.gql.dart'
    show Gmessage_types_enum, GUploadType;
import 'package:fe/services/clients/image_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:image_picker/image_picker.dart';
import 'chat_state.dart';
import 'send_state.dart';

class SendCubit extends Cubit<List<SendState>> {
  final Thread _thread;
  final ChatCubit _chatCubit;
  final User _self;

  SendCubit(
      {required Thread thread,
      required ChatCubit chatCubit,
      required User self})
      : _thread = thread,
        _self = self,
        _chatCubit = chatCubit,
        super([]);

  final _gqlClient = getIt<AuthGqlClient>();
  final _imageHandler = getIt<ImageClient>();

  Future<void> sendImage(XFile image) async {
    final messageId = UuidType.generate();

    await _send(
        Message.image(
            id: messageId,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            image: await image.readAsBytes(),
            user: _self), () async {
      final messageName =
          await _imageHandler.sendImage(image, _thread.id, GUploadType.Message);
      await _gqlClient
          .request(GInsertMessageReq((q) => q
            ..vars.message = messageName.imageName
            ..vars.messageId = messageId
            ..vars.messageType = Gmessage_types_enum.IMAGE
            ..vars.sourceId = _thread.id))
          .first;
    });
  }

  Future<void> sendText(String message) async {
    final messageId = UuidType.generate();

    final sendingMessage = Message.text(
        id: messageId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        text: message,
        user: _self);

    await _send(
        sendingMessage,
        () => _gqlClient
            .request(GInsertMessageReq((q) => q
              ..vars.message = message
              ..vars.messageId = messageId
              ..vars.messageType = Gmessage_types_enum.TEXT
              ..vars.sourceId = _thread.id))
            .first);
  }

  void _replaceSendState(SendState newSendState) {
    emit(List.of(state.map(
        (e) => e.message.id == newSendState.message.id ? newSendState : e)));
  }

  Future<void> _send<TData, TVars>(
      Message sendingMessage, Future<void> Function() sendFn,
      {firstSend = true}) async {
    if (firstSend) {
      emit(List.of(state)..add(SendState.sending(sendingMessage)));
    } else {
      _replaceSendState(SendState.sending(sendingMessage));
    }

    try {
      await sendFn();
    } on Failure catch (f) {
      _replaceSendState(SendState.failure(
        sendingMessage,
        f,
        resend: () => _send(sendingMessage, sendFn, firstSend: false),
      ));
      return;
    } on Exception catch (e) {
      _replaceSendState(SendState.failure(
        sendingMessage,
        Failure(status: FailureStatus.Custom, customMessage: e.toString()),
        resend: () => _send(sendingMessage, sendFn, firstSend: false),
      ));
      return;
    }

    // ignore: unawaited_futures
    _chatCubit.stream
        .firstWhere(
            (element) => element.maybeWhen(
                withMessages: (messages, _) =>
                    messages[sendingMessage.id] != null,
                orElse: () => false),
            //dummy or else prevents state errors when app closes and no stream was found.
            orElse: () => const ChatState.loading())
        .then((_) => emit(List.of(state
            .where((msgState) => msgState.message.id != sendingMessage.id))));
  }
}
