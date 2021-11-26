import 'package:fe/pages/chat/view/widgets/chats/message/overlays/hold_overlay/message_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../test_helpers/mocks.dart';
import '../../../../../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('should render message options', (tester) async {
    final caller = MockCaller();

    final messageOptions = [
      MessageOption(icon: Icons.ac_unit, text: 'one', onClick: caller.call),
      MessageOption(
          icon: Icons.bluetooth_audio, text: 'two', onClick: caller.call)
    ];

    await tester.pumpApp(MessageOptions(options: messageOptions));

    for (final messageOption in messageOptions) {
      expect(find.text(messageOption.text), findsOneWidget);
      expect(find.byIcon(messageOption.icon), findsOneWidget);
    }

    await tester.tap(find.text(messageOptions[0].text));

    verify(() => caller.call()).called(1);
  });
}
