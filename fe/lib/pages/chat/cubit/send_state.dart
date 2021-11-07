part of 'send_cubit.dart';

@immutable
class SendState extends Union2Impl<Sending, FailureSending> {
  @override
  String toString() => join((a) => a, (b) => b).toString();

  static const unions = Doublet<Sending, FailureSending>();

  SendState._(Union2<Sending, FailureSending> union) : super(union);

  factory SendState.sending({required SendingMessage message}) =>
      SendState._(unions.first(Sending(message: message)));

  factory SendState.failure(
          {required Failure failure,
          required SendingMessage message,
          required Future<void> Function() resend}) =>
      SendState._(unions.second(
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
