import 'package:fe/pages/chat/view/widgets/chat_input/chat_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/cross_fade.dart';
import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('should render row if open', (tester) async {
    await tester.pumpApp(ChatButtons(isOpen: true, manuallyShowButtons: () {}));

    expect(crossFadeShows(), Row);
  });

  testWidgets('should render icon button if closed', (tester) async {
    await tester
        .pumpApp(ChatButtons(isOpen: false, manuallyShowButtons: () {}));

    expect(crossFadeShows(), IconButton);
  });

  testWidgets('should call manuallyShowButtons on ', (tester) async {
    final caller = MockCaller();

    await tester
        .pumpApp(ChatButtons(isOpen: false, manuallyShowButtons: caller.call));

    await tester.tap(find.byType(AnimatedCrossFade).first);

    verify(() => caller.call()).called(1);
  });
  //should render icon button
}
