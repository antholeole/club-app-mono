import 'package:fe/data/models/message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_state.freezed.dart';

@freezed
class SendState with _$SendState {
  factory SendState.sending(Message message) = _Sending;
  factory SendState.failure(Message message, Failure failure,
      {required Future<void> Function() resend}) = _Failure;
}
