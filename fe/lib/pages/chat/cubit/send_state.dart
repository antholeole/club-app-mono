part of 'send_cubit.dart';

@immutable
class SendState extends Union2Impl<Sending, FailureSending> {
  static const unions = Doublet<Sending, FailureSending>();

  SendState._(Union2<Sending, FailureSending> union) : super(union);

  factory SendState.sending({required SendingMessage message}) =>
      SendState._(unions.first(Sending(message: message)));

  factory SendState.failure(
          {required Failure failure,
          required SendingMessage message,
          required VoidCallback resend}) =>
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
  final VoidCallback resend;

  const FailureSending(
      {required this.failure, required this.message, required this.resend});

  @override
  List<Object?> get props => [failure, message];
}
