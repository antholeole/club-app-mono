import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/data_carriers/sending_message.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/insert_message.req.gql.dart';

part 'send_state.dart';

class SendCubit extends Cubit<List<SendState>> {
  final Thread _thread;
  final ChatBloc _chatBloc;

  SendCubit({required Thread thread, required ChatBloc chatBloc})
      : _thread = thread,
        _chatBloc = chatBloc,
        super([]);

  final _gqlClient = getIt<AuthGqlClient>();

  Future<void> send(String message) async {
    final sendingMessage = SendingMessage(message: message);

    emit(List.of(state)..add(SendState.sending(message: sendingMessage)));

    await _send(sendingMessage, _thread.id);
  }

  void clear() {
    emit([]);
  }

  void _replaceSendState(SendState newSendState) {
    emit(List.of(state.map(
        (e) => e.message.id == newSendState.message.id ? newSendState : e)));
  }

  Future<void> _resend(
      SendingMessage sendingMessage, UuidType currentThreadId) async {
    _replaceSendState(SendState.sending(message: sendingMessage));
    await _send(sendingMessage, currentThreadId);
  }

  Future<void> _send(SendingMessage sendingMessage, UuidType threadId) async {
    try {
      await _gqlClient
          .request(GInsertMessageReq((q) => q
            ..vars.message = sendingMessage.message
            ..vars.messageId = sendingMessage.id
            ..vars.sourceId = threadId))
          .first;
    } on Failure catch (f) {
      _replaceSendState(
        SendState.failure(
            failure: f,
            message: sendingMessage,
            resend: () => _resend(sendingMessage, threadId)),
      );
      return;
    }

    // ignore: unawaited_futures
    _chatBloc.stream
        .firstWhere(
            (element) => element.join((fm) {
                  return fm.messages.any((msg) => msg.id == sendingMessage.id);
                }, (_) => false, (_) => false, (_) => false),
            //dummy or else prevents state errors when app closes and no stream was found.
            orElse: () => ChatState.loading())
        .then((_) => emit(List.of(state
            .where((msgState) => msgState.message.id != sendingMessage.id))));
  }
}
