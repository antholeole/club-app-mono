import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/title/chat_title.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('should display no thread text if no thread', (tester) async {
    await tester.pumpApp(const ChatTitle());

    expect(find.text(ChatTitle.NO_THREAD_TEXT), findsOneWidget);
  });

  testWidgets('should display thread title thread', (tester) async {
    final fakeThread = Thread(name: 'fake thread', id: UuidType.generate());

    await tester.pumpApp(ChatTitle(
      thread: fakeThread,
    ));

    expect(find.text(fakeThread.name), findsOneWidget);
  });
}
