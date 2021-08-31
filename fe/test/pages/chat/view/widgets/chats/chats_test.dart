import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/hold_overlay/message_overlay.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/reset_mock_bloc.dart';
import '../../../../../test_helpers/stub_cubit_stream.dart';

void main() {
  fakeAsync((async) {
    final fakeThread = Thread(name: 'fake thread', id: UuidType.generate());

    final mockChatCubit = MockChatCubit.getMock();
    final mockThreadCubit = MockThreadCubit.getMock();

    setUpAll(() {
      registerFallbackValue(fakeThread);
    });

    setUp(() {
      registerAllMockServices(needCubitAutoEvents: true);
      resetMockCubit(mockChatCubit);
      resetMockCubit(mockThreadCubit);
    });

    Widget wrapWithDependencies(Widget child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ChatCubit>(
            create: (_) => mockChatCubit,
          ),
          BlocProvider<ThreadCubit>(
            create: (_) => mockThreadCubit,
          ),
        ],
        child: child,
      );
    }

    testWidgets(
        'should query inital of with offset of now and some on inital render',
        (tester) async {
      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.thread(fakeThread));
      whenListen<ChatState>(mockChatCubit, const Stream.empty(),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(fakeThread, any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      expect(
          (verify(() => mockChatCubit.getChats(fakeThread, captureAny()))
                  .captured[0] as DateTime)
              .compareTo(clock.now()),
          greaterThan(0));
    });

    testWidgets('should show messages', (tester) async {
      const messageText = 'adsaodkaospdk';

      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.thread(fakeThread));
      whenListen<ChatState>(
          mockChatCubit,
          Stream.fromIterable([
            ChatState.fetchedMessages([
              Message(
                  user: User(id: UuidType.generate(), name: 'hi'),
                  id: UuidType.generate(),
                  message: messageText,
                  isImage: false,
                  createdAt: clock.now(),
                  updatedAt: clock.now())
            ], clock.now())
          ]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(fakeThread, any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      expect(find.text(messageText), findsOneWidget);
    });

    testWidgets('should handle failure state', (tester) async {
      const failure = Failure(status: FailureStatus.GQLMisc);

      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.thread(fakeThread));
      whenListen<ChatState>(
          mockChatCubit, Stream.fromIterable([ChatState.failure(failure)]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(fakeThread, any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      verify(() => getIt<Handler>().handleFailure(failure, any(),
          withPrefix: any(named: 'withPrefix', that: isA<String>()),
          toast: true)).called(1);
      expect(find.text(Chats.ERROR_COPY), findsOneWidget);
    });

    testWidgets('should build no chats on no more chats', (tester) async {
      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.thread(fakeThread));
      whenListen<ChatState>(mockChatCubit,
          Stream.fromIterable([ChatState.fetchedMessages([], null)]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(fakeThread, any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      expect(find.text(Chats.NO_MESSAGES_COPY), findsOneWidget);
    });

    testWidgets('should build no thead on no thread', (tester) async {
      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.noThread());
      whenListen<ChatState>(mockChatCubit,
          Stream.fromIterable([ChatState.fetchedMessages([], null)]),
          initialState: ChatState.inital());

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      debugDumpApp();

      expect(find.text(Chats.NO_THREAD_COPY), findsOneWidget);
    });

    testWidgets('held widget should display overlay', (tester) async {
      const messageText = 'adsaodkaospdk';
      const tapAwayKey = Key('tap-away');

      whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
          initialState: ThreadState.thread(fakeThread));
      whenListen<ChatState>(
          mockChatCubit,
          Stream.fromIterable([
            ChatState.fetchedMessages([
              Message(
                  user: User(id: UuidType.generate(), name: 'hi'),
                  id: UuidType.generate(),
                  message: messageText,
                  isImage: false,
                  createdAt: clock.now(),
                  updatedAt: clock.now())
            ], clock.now())
          ]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(fakeThread, any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(Container(
        key: tapAwayKey,
        child: wrapWithDependencies(const Chats()),
      ));
      await tester.pump();

      await tester.longPress(find.text(messageText));
      await tester.pump();

      expect(find.byType(MessageOverlay), findsOneWidget);

      await tester.tap(find.byKey(tapAwayKey, skipOffstage: false),
          warnIfMissed: false);
      await tester.pump();

      expect(find.byType(MessageOverlay), findsNothing);
    });

    testWidgets('should clear messages on new thread', (tester) async {
      const messageText = 'adsaodkaospdk';
      final newThread = Thread(name: 'new thread', id: UuidType.generate());

      final threadCubitController = stubCubitStream<ThreadState>(
          mockThreadCubit,
          initialState: ThreadState.thread(fakeThread));

      whenListen<ChatState>(
          mockChatCubit,
          Stream.fromIterable([
            ChatState.fetchedMessages([
              Message(
                  user: User(id: UuidType.generate(), name: 'hi'),
                  id: UuidType.generate(),
                  message: messageText,
                  isImage: false,
                  createdAt: clock.now(),
                  updatedAt: clock.now())
            ], null)
          ]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(any(), any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const Chats()));
      await tester.pump();

      expect(find.text(messageText), findsOneWidget);

      threadCubitController.add(ThreadState.thread(newThread));
      await tester.pump();

      expect(find.text(messageText), findsNothing);

      verify(() => mockChatCubit.getChats(newThread, any())).called(1);
      verify(() => mockChatCubit.getChats(fakeThread, any())).called(1);
    });
  });
}
