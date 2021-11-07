import 'package:fe/pages/chat/view/widgets/chat_input/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/cross_fade.dart';
import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('should show container on not sendable', (tester) async {
    await tester.pumpApp(SendButton(isSendable: false, onClick: () {}));

    expect(crossFadeShows(), Container);
  });

  testWidgets('should show button on sendable', (tester) async {
    await tester.pumpApp(SendButton(isSendable: true, onClick: () {}));

    expect(crossFadeShows(), Transform);
  });

  testWidgets('should call send on button click', (tester) async {
    final caller = MockCaller();

    await tester.pumpApp(SendButton(isSendable: true, onClick: caller.call));

    await tester.tap(find.byType(AnimatedCrossFade).first);

    verify(() => caller.call()).called(1);
  });
}
