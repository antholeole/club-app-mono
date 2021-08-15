import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<ChatBottomSheetCubit, ChatBottomSheetState>('should start closed',
      build: () => ChatBottomSheetCubit(),
      verify: (cubit) => expect(cubit.state.isOpen, equals(false)));

  blocTest<ChatBottomSheetCubit, ChatBottomSheetState>(
    'should emit states equal to inputted state, ignoring double states',
    build: () => ChatBottomSheetCubit(),
    act: (cubit) {
      cubit.setState(true);
      cubit.setState(false);
      cubit.setState(false);
      cubit.setState(true);
    },
    expect: () => [
      const ChatBottomSheetState(isOpen: true),
      const ChatBottomSheetState(isOpen: false),
      const ChatBottomSheetState(isOpen: true)
    ],
  );
}
