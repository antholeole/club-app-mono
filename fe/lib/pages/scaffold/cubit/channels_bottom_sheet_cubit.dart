import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'channels_bottom_sheet_state.dart';

class ChatBottomSheetCubit extends Cubit<ChatBottomSheetState> {
  ChatBottomSheetCubit() : super(const ChatBottomSheetState());

  void setState(bool isOpen) => emit(ChatBottomSheetState(isOpen: isOpen));
}
