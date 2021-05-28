import 'package:bloc/bloc.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  void setThread(UuidType? threadId) => emit(ChatSetThread(threadId: threadId));

  ChatCubit() : super(ChatInitial());
}
