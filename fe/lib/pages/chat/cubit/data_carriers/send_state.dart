import 'package:equatable/equatable.dart';
import 'package:fe/pages/chat/cubit/data_carriers/sending_message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

@immutable
class MessageSendState extends Union2Impl<Sending, FailureSending> {
  @override
  String toString() => join((a) => a, (b) => b).toString();

  static const unions = Doublet<Sending, FailureSending>();

  MessageSendState._(Union2<Sending, FailureSending> union) : super(union);

  factory MessageSendState.sending({required SendingMessage message}) =>
      MessageSendState._(unions.first(Sending(message: message)));

  factory MessageSendState.failure(
          {required Failure failure,
          required SendingMessage message,
          required Future<void> Function() resend}) =>
      MessageSendState._(unions.second(
          FailureSending(failure: failure, message: message, resend: resend)));

  SendingMessage get message => join((s) => s.message, (sf) => sf.message);
}

class Sending extends Equatable {
  final SendingMessage message;

  const Sending({required this.message});

  @override
  List<Object?> get props => [message];
}

class FailureSending extends Equatable {
  final Failure failure;
  final SendingMessage message;
  final Future<void> Function() resend;

  const FailureSending(
      {required this.failure, required this.message, required this.resend});

  @override
  List<Object?> get props => [failure, message];
}
