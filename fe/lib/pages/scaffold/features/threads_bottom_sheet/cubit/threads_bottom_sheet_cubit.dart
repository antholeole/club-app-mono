import 'package:bloc/bloc.dart';

class ThreadsBottomSheetCubit extends Cubit<bool> {
  ThreadsBottomSheetCubit() : super(false);

  void setState(bool isOpen) => emit(isOpen);
}
