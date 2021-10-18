import 'package:fe/pages/chat/view/widgets/title/club_chat_title.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/fixtures/mocks.dart';
import '../../../../test_helpers/pump_app.dart';
import '../../../../test_helpers/stub_bloc_stream.dart';

void main() {
  final MockChatBottomSheetCubit mockChatBottomSheetCubit =
      MockChatBottomSheetCubit.getMock();

  Widget build({required Widget child}) {
    return BlocProvider<ChatBottomSheetCubit>(
      create: (_) => mockChatBottomSheetCubit,
      child: child,
    );
  }

  testWidgets('should call onclick on click', (tester) async {
    stubBlocStream(mockChatBottomSheetCubit, initialState: false);
    final mockCaller = MockCaller();

    await tester.pumpApp(build(child: ClubChatTitle(onClick: mockCaller.call)));
    await tester.tap(find.byIcon(Icons.expand_more));

    verify(() => mockCaller.call()).called(1);
  });

  testWidgets('arrow should flip on bottomSheetOpen or close', (tester) async {
    final controller =
        stubBlocStream(mockChatBottomSheetCubit, initialState: false);

    await tester.pumpApp(build(child: ClubChatTitle(onClick: () {})));

    expect(
        (find.byType(AnimatedRotation).evaluate().first.widget
                as AnimatedRotation)
            .turns,
        0);

    controller.add(true);
    await tester.pumpAndSettle();

    expect(
        (find.byType(AnimatedRotation).evaluate().first.widget
                as AnimatedRotation)
            .turns,
        0.5);
  });
}
