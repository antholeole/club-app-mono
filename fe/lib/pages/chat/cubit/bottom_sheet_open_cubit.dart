import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_sheet_open_state.dart';

class ChatBottomSheetCubit extends Cubit<ChatBottomSheetState> {
  ChatBottomSheetCubit() : super(ChatBottomSheetInitial());

  void setState(bool isOpen) =>
      emit(ChatBottomSheetChangeState(isOpen: isOpen));
}
