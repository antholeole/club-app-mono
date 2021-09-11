part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class RetryEvent extends Equatable implements ChatEvent {
  const RetryEvent();

  @override
  List<Object?> get props => [];
}

class FetchMessagesEvent extends Equatable implements ChatEvent {
  const FetchMessagesEvent();

  @override
  List<Object?> get props => [];
}

class _ThreadChangeEvent extends Equatable implements ChatEvent {
  @override
  List<Object?> get props => [];
}
