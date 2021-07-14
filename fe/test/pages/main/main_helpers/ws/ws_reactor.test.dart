import 'package:fe/pages/main/main_helpers/ws/ws_provider.dart';
import 'package:fe/pages/main/main_helpers/ws/ws_reactor.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:flutter_test/flutter_test.dart';
import './ws_reactor.test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([WsClient])
void main() {
  testWidgets('Should never show if not connected',
      (WidgetTester tester) async {
    final MockWsClient mockClient = MockWsClient();

    await tester.pumpWidget(WsProvider(
        wsClient: mockClient, child: WsReactor(sizeCallback: (_) {})));

    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
