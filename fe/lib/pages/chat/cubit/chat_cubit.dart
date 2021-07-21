import 'package:bloc/bloc.dart';
import 'package:fe/data/models/thread.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  void setThread(Thread? thread) => emit(ChatSetThread(thread: thread));

  ChatCubit() : super(const ChatInitial());
}
