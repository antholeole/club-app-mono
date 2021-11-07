part of 'chat_bloc.dart';

@immutable
class ChatState extends Union4Impl<FetchedMessages, FetchMessagesFailure,
    FetchMessagesLoading, NoThread> {
  @override
  String toString() => join((a) => a, (b) => b, (c) => c, (d) => d).toString();

  static const unions = Quartet<FetchedMessages, FetchMessagesFailure,
      FetchMessagesLoading, NoThread>();

  ChatState._(
      Union4<FetchedMessages, FetchMessagesFailure, FetchMessagesLoading,
              NoThread>
          union)
      : super(union);

  factory ChatState.fetchedMessages(FetchedMessages fetchedMessages) =>
      ChatState._(unions.first(fetchedMessages));

  factory ChatState.failure(Failure failure) =>
      ChatState._(unions.second(FetchMessagesFailure(failure: failure)));

  factory ChatState.loading() =>
      ChatState._(unions.third(const FetchMessagesLoading()));

  factory ChatState.noThread() => ChatState._(unions.fourth(const NoThread()));
}

@immutable
class FetchedMessages extends Equatable {
  final Map<UuidType, Message> _messages;
  final bool hasReachedMax;

  Iterable<Message> get messages => _messages.values.toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  FetchedMessages({required List<Message> messages, this.hasReachedMax = false})
      : _messages = Map.fromEntries(
            messages.map((message) => MapEntry(message.id, message)));

  FetchedMessages.withNewReaction(
      {required FetchedMessages old, required Reaction newReaction})
      : hasReachedMax = old.hasReachedMax,
        _messages = Map.fromEntries([
          ...old._messages.entries,
          MapEntry(
              newReaction.messageId,
              old._messages[newReaction.messageId]!
                  .copyWithNewReaction(newReaction))
        ]);

  FetchedMessages.withNewMessage(
      {required FetchedMessages old, required Message newMessage})
      : hasReachedMax = old.hasReachedMax,
        _messages = Map.fromEntries(
            [...old._messages.entries, MapEntry(newMessage.id, newMessage)]);

  FetchedMessages.withoutReaction(
      {required FetchedMessages old, required Reaction deletedReaction})
      : hasReachedMax = old.hasReachedMax,
        _messages = Map.from(old._messages) {
    final newMessage = _messages[deletedReaction.messageId]
        ?.copyWithoutReaction(deletedReaction);
    if (newMessage != null) {
      _messages[deletedReaction.messageId] = newMessage;
    }
  }

  Message? getMessage(UuidType messageId) => _messages[messageId];

  @override
  List<Object?> get props => [messages, hasReachedMax];
}

class FetchMessagesFailure extends Equatable {
  final Failure failure;

  const FetchMessagesFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class FetchMessagesLoading extends Equatable {
  const FetchMessagesLoading();

  @override
  List<Object?> get props => [];
}

class NoThread extends Equatable {
  const NoThread();

  @override
  List<Object?> get props => [];
}
