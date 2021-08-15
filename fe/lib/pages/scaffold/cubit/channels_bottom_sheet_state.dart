part of 'channels_bottom_sheet_cubit.dart';

@immutable
class ChatBottomSheetState extends Equatable {
  final bool isOpen;

  const ChatBottomSheetState({this.isOpen = false});

  @override
  List<Object?> get props => [isOpen];
}
