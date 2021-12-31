import 'package:fe/data/models/message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.withMessages(Map<UuidType, Message> messages,
      [@Default(false) bool hasReachMax]) = _WithMessages;

  const factory ChatState.failure(Failure failure) = _Failure;
  const factory ChatState.loading() = _Loading;
}
