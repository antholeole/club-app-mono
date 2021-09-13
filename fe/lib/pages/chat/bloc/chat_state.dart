part of 'chat_bloc.dart';

enum EdgeFetchState { NotFetching, Fetching, ErrorFetching }

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
  final List<Message> messages;

  final bool hasReachedMax;

  final EdgeFetchState topFetchState;
  final EdgeFetchState bottomFetchState;

  const FetchedMessages(
      {required this.messages,
      this.hasReachedMax = false,
      this.topFetchState = EdgeFetchState.NotFetching,
      this.bottomFetchState = EdgeFetchState.NotFetching});

  @override
  List<Object?> get props =>
      [messages, topFetchState, bottomFetchState, hasReachedMax];
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
