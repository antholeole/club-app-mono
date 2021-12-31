import 'package:bloc/bloc.dart';

class ChatBottomSheetCubit extends Cubit<bool> {
  ChatBottomSheetCubit() : super(false);

  void setState(bool isOpen) => emit(isOpen);
}
