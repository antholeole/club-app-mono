import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/data_carriers/sending_message.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/insert_message.req.gql.dart';

part 'send_state.dart';

class SendCubit extends Cubit<List<SendState>> {
  final ThreadCubit _threadCubit;
  final ChatBloc _chatBloc;

  SendCubit({required ThreadCubit threadCubit, required ChatBloc chatBloc})
      : _threadCubit = threadCubit,
        _chatBloc = chatBloc,
        super([]) {
    _threadCubit.stream.listen((event) => emit([]));
  }

  final _gqlClient = getIt<AuthGqlClient>();
  final _localUserService = getIt<LocalUserService>();

  Future<void> send(String message) async {
    final currentThreadId = _threadCubit.state.thread!.id;

    final sendingMessage = SendingMessage(message: message);

    emit(List.of(state)..add(SendState.sending(message: sendingMessage)));

    await _send(sendingMessage, currentThreadId);
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
    final selfId = await _localUserService.getLoggedInUserId();

    try {
      await _gqlClient.request(GInsertMessageReq((q) => q
        ..vars.message = sendingMessage.message
        ..vars.selfId = selfId
        ..vars.messageId = sendingMessage.id
        ..vars.threadId = threadId));
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
            (element) => element.join(
                (fm) => fm.messages.any((msg) => msg.id == sendingMessage.id),
                (_) => false,
                (_) => false,
                (_) => false),
            //dummy or else prevents state errors when app closes and no stream was found.
            orElse: () => ChatState.loading())
        .then((_) => emit(List.of(state
            .where((msgState) => msgState.message.id != sendingMessage.id))));
  }
}
