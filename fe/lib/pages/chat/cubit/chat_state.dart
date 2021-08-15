part of 'chat_cubit.dart';

@immutable
class ChatState extends Union3Impl<ChatInital, ChatFetchedMessages,
    ChatFetchMessagesFailure> {
  static const unions =
      Triplet<ChatInital, ChatFetchedMessages, ChatFetchMessagesFailure>();

  ChatState._(
      Union3<ChatInital, ChatFetchedMessages, ChatFetchMessagesFailure> union)
      : super(union);

  factory ChatState.inital() => ChatState._(unions.first(const ChatInital()));

  factory ChatState.fetchedMessages(
          List<Message> messages, DateTime? lastSentAt) =>
      ChatState._(unions.second(
          ChatFetchedMessages(messages: messages, lastSentAt: lastSentAt)));

  factory ChatState.failure(Failure failure) =>
      ChatState._(unions.third(ChatFetchMessagesFailure(failure: failure)));
}

class ChatInital extends Equatable {
  const ChatInital();

  @override
  List<Object?> get props => [];
}

class ChatFetchedMessages extends Equatable {
  final List<Message> messages;
  final DateTime? lastSentAt;

  const ChatFetchedMessages({required this.messages, this.lastSentAt});

  @override
  List<Object?> get props => [messages];
}

class ChatFetchMessagesFailure extends Equatable {
  final Failure failure;

  const ChatFetchMessagesFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
