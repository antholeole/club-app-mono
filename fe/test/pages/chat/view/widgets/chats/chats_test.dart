import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/data_carriers/sending_message.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/chat_page_message_display.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/sending_message.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/reset_mock_bloc.dart';

void main() {
  final fakeUser =
      User(name: 'apsdkaoisdmaoin jasd asjdmn', id: UuidType.generate());
  final fakeMessage = Message(
      user: fakeUser,
      id: UuidType.generate(),
      message: 'asdas',
      isImage: false,
      createdAt: clock.now(),
      updatedAt: clock.now());

  final MockMessageOverlayCubit mockMessageOverlayCubit =
      MockMessageOverlayCubit.getMock();
  final MockChatBloc mockChatBloc = MockChatBloc.getMock();
  final MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
  final MockSendCubit mockSendCubit = MockSendCubit.getMock();

  Widget wrapWithDependencies({required Widget child}) {
    return MultiBlocProvider(providers: [
      BlocProvider<MessageOverlayCubit>(create: (_) => mockMessageOverlayCubit),
      BlocProvider<ChatBloc>(create: (_) => mockChatBloc),
      BlocProvider<UserCubit>(create: (_) => UserCubit(fakeUser)),
      BlocProvider<ThreadCubit>(create: (_) => mockThreadCubit),
      BlocProvider<SendCubit>(create: (_) => mockSendCubit),
    ], child: child);
  }

  setUp(() {
    registerAllMockServices();

    <BlocBase<dynamic>>[
      mockMessageOverlayCubit,
      mockChatBloc,
      mockThreadCubit,
      mockSendCubit
    ].forEach((bloc) => resetMockBloc(bloc));

    when(() => mockMessageOverlayCubit.scrollController)
        .thenReturn(ScrollController());

    whenListen<MessageOverlayState>(
        mockMessageOverlayCubit, const Stream<MessageOverlayState>.empty(),
        initialState: MessageOverlayState.none());
  });

  group('chat bloc failure', () {
    final failure = Failure(status: FailureStatus.HttpMisc);

    setUp(() {
      whenListen<List<SendState>>(
          mockSendCubit, const Stream<List<SendState>>.empty(),
          initialState: []);

      whenListen<ChatState>(mockChatBloc,
          Stream<ChatState>.fromIterable([ChatState.failure(failure)]),
          initialState: ChatState.loading());
    });

    testWidgets('should call handle failure', (tester) async {
      await tester.pumpApp(wrapWithDependencies(child: const Chats()));
      await tester.pump();

      verify(() => getIt<Handler>().handleFailure(failure, any())).called(1);
    });

    testWidgets('should retry on tap retry', (tester) async {
      await tester.pumpApp(wrapWithDependencies(child: const Chats()));
      await tester.pump();

      await tester.tap(find.byType(PillButton));
      await tester.pump();

      verify(() => mockChatBloc.add(ThreadChangeEvent())).called(1);
    });
  });

  group('fetched messages', () {
    testWidgets('should render unsents', (tester) async {
      whenListen<List<SendState>>(
          mockSendCubit, const Stream<List<SendState>>.empty(), initialState: [
        SendState.sending(message: SendingMessage(message: 'asdasd'))
      ]);

      whenListen<ChatState>(mockChatBloc, const Stream<ChatState>.empty(),
          initialState: ChatState.fetchedMessages(
              FetchedMessages(messages: [], hasReachedMax: true)));

      await tester.pumpApp(wrapWithDependencies(child: const Chats()));
      await tester.pump();

      expect(find.byType(SendingMessageDisplay), findsWidgets);
    });

    group('no unsents', () {
      setUp(() {
        whenListen<List<SendState>>(
            mockSendCubit, const Stream<List<SendState>>.empty(),
            initialState: []);
      });

      testWidgets('should add fetchMessages Event if overscrolled',
          (tester) async {
        whenListen<ChatState>(
            mockChatBloc,
            Stream<ChatState>.fromIterable([
              ChatState.fetchedMessages(FetchedMessages(
                  messages: [for (var i = 0; i < 10; i++) fakeMessage],
                  hasReachedMax: false))
            ]),
            initialState: ChatState.loading());

        await tester.pumpApp(wrapWithDependencies(child: const Chats()));
        await tester.pump();

        await tester.drag(
            find.text(fakeMessage.message), const Offset(0, -500));
        await tester.pump();

        verify(() => mockChatBloc.add(const FetchMessagesEvent())).called(1);
      });

      testWidgets('should render chatPageMessageDisplay on message',
          (tester) async {
        whenListen<ChatState>(
            mockChatBloc,
            Stream<ChatState>.fromIterable([
              ChatState.fetchedMessages(FetchedMessages(
                  messages: [for (var i = 0; i < 10; i++) fakeMessage],
                  hasReachedMax: false))
            ]),
            initialState: ChatState.loading());

        await tester.pumpApp(wrapWithDependencies(child: const Chats()));
        await tester.pump();

        expect(find.byType(ChatPageMessageDisplay), findsWidgets);
      });

      testWidgets('should display no chats copy with no messages',
          (tester) async {
        whenListen<ChatState>(
            mockChatBloc,
            Stream<ChatState>.fromIterable([
              ChatState.fetchedMessages(
                  FetchedMessages(messages: [], hasReachedMax: true))
            ]),
            initialState: ChatState.loading());

        await tester.pumpApp(wrapWithDependencies(child: const Chats()));
        await tester.pump();

        expect(find.text(Chats.NO_MESSAGES_COPY), findsOneWidget);
      });
    });
  });
}
