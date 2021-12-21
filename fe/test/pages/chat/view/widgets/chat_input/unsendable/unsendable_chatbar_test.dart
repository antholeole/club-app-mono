import 'package:fe/pages/chat/view/widgets/chat_input/unsendable/unsendable_chatbar.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../test_helpers/pump_app.dart';

void main() {
  for (UnsendableReason unsendableReason in UnsendableReason.values) {
    testWidgets('should render unsendable reason $unsendableReason text',
        (tester) async {
      await tester.pumpApp(UnsendableChatbar(reason: unsendableReason));

      expect(find.text(unsendableReason.reason), findsOneWidget);
    });
  }
}
