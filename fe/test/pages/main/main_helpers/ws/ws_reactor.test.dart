import 'package:fe/pages/main/main_helpers/ws/ws_provider.dart';
import 'package:fe/pages/main/main_helpers/ws/ws_reactor.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:flutter_test/flutter_test.dart';
import './ws_reactor.test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([WsClient])
void main() {
  testWidgets(
      'Should never show if not connected', (WidgetTester tester) async {});
}
