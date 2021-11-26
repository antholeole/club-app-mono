import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chat_input/chat_bar.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../../../test_helpers/cross_fade.dart';
import '../../../../../test_helpers/mocks.dart';
import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';

void main() {
  const fakeText = 'asdpajsdoiasjdomas';
  final fakeThread =
      Thread(name: 'asdasdasdaasdasbbbb', id: UuidType.generate());

  final MockSendCubit mockSendCubit = MockSendCubit.getMock();

  Widget wrapWithDependencies({required Widget child}) {
    return MultiProvider(
      providers: [
        BlocProvider<SendCubit>(create: (_) => mockSendCubit),
        Provider.value(value: fakeThread)
      ],
      child: child,
    );
  }

  setUp(() {
    registerAllMockServices();
  });

  group('send', () {
    final sendButtonFinder = find.byType(AnimatedCrossFade).last;

    testWidgets('should show send button on text', (tester) async {
      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));

      expect(crossFadeShows(finder: sendButtonFinder), Container);

      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      expect(crossFadeShows(finder: sendButtonFinder), Transform);
    });

    testWidgets('should call SendCubit.onSend on send', (tester) async {
      when(() => mockSendCubit.send(fakeText)).thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));
      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      verify(() => mockSendCubit.send(any())).called(1);
    });

    testWidgets('should call handleFailure on failure', (tester) async {
      final failure = Failure(status: FailureStatus.GQLMisc);

      when(() => mockSendCubit.send(fakeText)).thenThrow(failure);

      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));
      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      verify(() => getIt<Handler>().handleFailure(failure, any()));
    });

    testWidgets('should clear controller', (tester) async {
      when(() => mockSendCubit.send(fakeText)).thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));
      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      expect(
          (find.byType(TextField).first.evaluate().first.widget as TextField)
              .controller!
              .text,
          '');
    });
  });

  group('text update', () {
    testWidgets('should open settings if has text', (tester) async {
      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));

      //initally show row of buttons
      expect(crossFadeShows(), Row);

      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      //close button
      expect(crossFadeShows(), IconButton);
    });

    testWidgets('should close settings if no text', (tester) async {
      await tester.pumpApp(wrapWithDependencies(child: const ChatBar()));

      expect(crossFadeShows(), Row, reason: 'initally show row of buttons');

      await tester.enterText(find.byType(TextField), fakeText);
      await tester.pumpAndSettle();

      expect(crossFadeShows(), IconButton, reason: 'close button should show');

      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      expect(crossFadeShows(), Row);
    });
  });
}
