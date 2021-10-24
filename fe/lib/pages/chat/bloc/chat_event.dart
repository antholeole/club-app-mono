part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class FetchMessagesEvent extends Equatable implements ChatEvent {
  const FetchMessagesEvent();

  @override
  List<Object?> get props => [];
}

class ThreadChangeEvent extends Equatable implements ChatEvent {
  @override
  List<Object?> get props => [];
}

class _NewMessageEvent extends Equatable implements ChatEvent {
  final Message newMessage;

  const _NewMessageEvent({required this.newMessage});

  @override
  List<Object?> get props => [newMessage];
}

class _UpdatedReactionEvent extends Equatable implements ChatEvent {
  final Reaction updatedReaction;
  final bool deleted;

  const _UpdatedReactionEvent(
      {required this.updatedReaction, required this.deleted});

  @override
  List<Object?> get props => [updatedReaction, deleted];
}
