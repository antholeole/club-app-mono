part of 'bottom_sheet_open_cubit.dart';

@immutable
abstract class ChatBottomSheetState {
  final bool isOpen;

  const ChatBottomSheetState({this.isOpen = false});
}

class ChatBottomSheetInitial extends ChatBottomSheetState {
  const ChatBottomSheetInitial() : super(isOpen: false);
}

class ChatBottomSheetChangeState extends ChatBottomSheetState {
  const ChatBottomSheetChangeState({required bool isOpen})
      : super(isOpen: isOpen);
}
