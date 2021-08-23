import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/chat_page.dart';
import 'package:fe/pages/chat/view/widgets/chats/chats.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/group.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/stub_cubit_stream.dart';

void main() {
  final mockMainCubit = MockMainCubit.getMock();
  final mockPageCubit = MockPageCubit.getMock();
  final mockScaffoldCubit = MockScaffoldCubit.getMock();
  final mockThreadCubit = MockThreadCubit.getMock();
  final mockChatCubit = MockChatCubit.getMock();

  final fakeThread = Thread(
      id: UuidType('767ca6a2-90a4-495b-9d44-9bab79cf497d'), name: 'fake fake');

  final fakeGroup = mockGroupAdmin;

  void setupMocks() {
    when(() => getIt<SharedPreferences>().remove(any()))
        .thenAnswer((_) async => true);
  }

  setUp(() async {
    registerFallbackValue(fakeThread);
    registerFallbackValue(DateTime.now());
    registerFallbackValue(const MainScaffoldParts());
    registerFallbackValue(mockGroupAdmin);

    resetMockCubit(mockThreadCubit);
    resetMockCubit(mockChatCubit);
    resetMockCubit(mockMainCubit);
    resetMockCubit(mockPageCubit);
    resetMockCubit(mockScaffoldCubit);

    await registerAllMockServices();
    setupMocks();
  });

  group('chat page', () {
    final mockGroup = mockGroupAdmin;
    testWidgets('should render chat view', (tester) async {
      whenListen(
        mockPageCubit,
        Stream<PageState>.fromIterable([PageState.chatPage()]),
        initialState: PageState.chatPage(),
      );

      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withGroup(mockGroup));

      whenListen(mockScaffoldCubit, Stream<ScaffoldState>.fromIterable([]),
          initialState: const ScaffoldUpdate(MainScaffoldParts()));

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ScaffoldCubit>(create: (_) => mockScaffoldCubit),
            BlocProvider<MainCubit>(create: (_) => mockMainCubit),
            BlocProvider<PageCubit>(create: (_) => mockPageCubit)
          ],
          child: ChatPage(
            group: mockGroup,
          ),
        ),
      );

      await expectLater(find.byType(ChatView), findsOneWidget);
    });
  });

  group('chat view', () {
    setUp(() async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.chatPage());

      whenListen(mockScaffoldCubit, Stream<ScaffoldState>.fromIterable([]));

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.thread(fakeThread));

      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withGroup(fakeGroup));

      whenListen(mockChatCubit, Stream<ChatState>.fromIterable([]),
          initialState: ChatState.inital());

      when(() => mockChatCubit.getChats(any(), any()))
          .thenAnswer((_) async => null);
    });

    Widget wrapWithDependencies(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider<PageCubit>(create: (_) => mockPageCubit),
        BlocProvider<ScaffoldCubit>(create: (_) => mockScaffoldCubit),
        BlocProvider<MainCubit>(create: (_) => mockMainCubit),
        BlocProvider<ThreadCubit>(create: (_) => mockThreadCubit),
        BlocProvider<ChatCubit>(create: (_) => mockChatCubit),
      ], child: child);
    }

    testWidgets('should update scaffold on render', (tester) async {
      await tester.pumpApp(wrapWithDependencies(const ChatView()));

      verify(() => mockScaffoldCubit.updateMainParts(any())).called(1);
    });

    testWidgets('should update scaffold on tab switch in', (tester) async {
      resetMockCubit(mockPageCubit);

      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.chatPage());

      await tester.pumpApp(wrapWithDependencies(Builder(builder: (context) {
        return context
            .watch<PageCubit>()
            .state
            .join((_) => Container(), (_) => const ChatView());
      })));

      verify(() => mockScaffoldCubit.updateMainParts(any())).called(1);
    });

    testWidgets(
      'should call cubit new group on group switch',
      (tester) async {
        final groupA = Group(
            admin: false,
            id: UuidType('767ca6a2-90a4-495b-9d44-9bab79cf497d'),
            name: 'groupA');

        final groupB = Group(
            admin: false,
            id: UuidType('287e70a1-b4ca-4fa8-8cb4-7927671f4c7e'),
            name: 'groupB');

        final mainStateCubitController = stubCubitStream(
          mockMainCubit,
          initialState: MainState.withGroup(groupA),
        );

        when(() => mockThreadCubit.newGroup(any()))
            .thenAnswer((invocation) async => null);

        await tester.pumpApp(wrapWithDependencies(const ChatView()));
        mainStateCubitController.add(MainState.withGroup(groupB));
        await tester.pump(const Duration(milliseconds: 10));

        verify(() => mockThreadCubit.newGroup(groupB)).called(1);
      },
    );

    testWidgets(
      'should render chats widget only on thread selected',
      (tester) async {
        resetMockCubit(mockThreadCubit);

        final threadStateCubitController = stubCubitStream(mockThreadCubit,
            initialState: ThreadState.noThread());

        await tester.pumpApp(wrapWithDependencies(const ChatView()));
        expect(find.byType(Chats), findsNothing);

        threadStateCubitController.add(ThreadState.thread(
            Thread(id: UuidType.generate(), name: 'adsdas')));
        await tester.pump(const Duration(milliseconds: 10));

        expect(find.byType(Chats), findsOneWidget);
      },
    );

    testWidgets('should switch to thread on page cubit emit thread',
        (tester) async {
      resetMockCubit(mockPageCubit);

      whenListen(
          mockPageCubit,
          Stream<PageState>.fromIterable(
              [PageState.chatPage(toThread: fakeThread)]),
          initialState: PageState.chatPage());

      await tester.pumpApp(wrapWithDependencies(const ChatView()));

      verify(() => mockThreadCubit.switchToThread(fakeThread)).called(1);
    });

    testWidgets(
      'should cache thread on app pause',
      (tester) async {
        when(() => mockThreadCubit.cacheThread())
            .thenAnswer((invocation) async => null);

        await tester.pumpApp(wrapWithDependencies(const ChatView()));

        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);

        verify(() => mockThreadCubit.cacheThread()).called(1);

        //cleanup
        tester.binding
            .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      },
    );
  });
}
