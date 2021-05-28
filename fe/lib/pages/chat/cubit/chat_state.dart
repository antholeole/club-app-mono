part of 'chat_cubit.dart';

@immutable
abstract class ChatState {
  final UuidType? threadId;

  const ChatState({this.threadId});
}

class ChatInitial extends ChatState {
  ChatInitial() : super(threadId: null);
}

class ChatSetThread extends ChatState {
  const ChatSetThread({UuidType? threadId}) : super(threadId: threadId);
}
