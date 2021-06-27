part of 'chat_cubit.dart';

@immutable
abstract class ChatState {
  final Thread? thread;

  const ChatState({this.thread});
}

class ChatInitial extends ChatState {
  ChatInitial() : super(thread: null);
}

class ChatSetThread extends ChatState {
  const ChatSetThread({Thread? thread}) : super(thread: thread);
}
