import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/chat/view/widgets/title/club_chat_title.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../test_helpers/fixtures/group.dart';
import '../../../../test_helpers/fixtures/mocks.dart';
import '../../../../test_helpers/get_it_helpers.dart';
import '../../../../test_helpers/pump_app.dart';
import '../../../../test_helpers/reset_mock_bloc.dart';
import '../../../../test_helpers/stub_cubit_stream.dart';
import '../../../../test_helpers/stub_gql_response.dart';

void main() {
  group('chat title', () {
    final fakeThread = Thread(name: 'fake thread', id: UuidType.generate());

    MockChatBottomSheetCubit mockChatBottomSheetCubit =
        MockChatBottomSheetCubit.getMock();
    MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
    MockPageCubit mockPageCubit = MockPageCubit.getMock();

    setUpAll(() {
      registerFallbackValue(FakeBuildContext());
    });

    setUp(() {
      resetMockBloc(mockChatBottomSheetCubit);
      resetMockBloc(mockThreadCubit);
      resetMockBloc(mockPageCubit);
    });
    testWidgets(
        'clicking on flippable icon should bring up thread bottom sheet',
        (tester) async {
      await registerAllMockServices();

      final mockMainCubit = MockMainCubit.getMock();

      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withGroup(mockGroupAdmin));

      whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
          initialState: false);

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.noThread());

      whenListen(mockPageCubit, Stream<MockPageState>.fromIterable([]),
          initialState: PageState.eventPage());

      when(() => mockPageCubit.bottomSheet(any()))
          .thenAnswer((invocation) async => null);

      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
          error: (_) => const Failure(status: FailureStatus.GQLMisc));

      await tester.pumpApp(UserProvider(
        user: User(
            id: UuidType.generate(), name: 'ant', profilePictureUrl: 'asasd'),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<PageCubit>(create: (_) => mockPageCubit),
              BlocProvider<MainCubit>(create: (_) => mockMainCubit),
              BlocProvider<ChatBottomSheetCubit>(
                create: (_) => mockChatBottomSheetCubit,
              ),
              BlocProvider<ThreadCubit>(
                create: (_) => mockThreadCubit,
              )
            ],
            child: Builder(
                builder: (context) => ChatTitle(chatProviderContext: context))),
      ));

      await tester.tap(find.byType(FlippableIcon));
      await tester.pump(const Duration(milliseconds: 10));

      verify(() => mockPageCubit.bottomSheet(any())).called(1);

      //clean up
      await tester.tap(find.byType(ChatTitle),
          warnIfMissed: false); // any widget that isn't in the bottom sheet
      await tester.pump(const Duration(milliseconds: 10));
    });

    testWidgets('should display "select thread" on no thread', (tester) async {
      whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
          initialState: false);

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.noThread());

      await tester.pumpApp(MultiBlocProvider(
          providers: [
            BlocProvider<ChatBottomSheetCubit>(
              create: (_) => mockChatBottomSheetCubit,
            ),
            BlocProvider<ThreadCubit>(
              create: (_) => mockThreadCubit,
            )
          ],
          child: Builder(
              builder: (context) => ChatTitle(chatProviderContext: context))));

      expect(find.text(ChatTitle.NO_THREAD_TEXT), findsOneWidget);
    });

    testWidgets('should display and respond to thread name', (tester) async {
      final secondThread = Thread(name: 'second', id: UuidType.generate());

      whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
          initialState: false);

      final threadController = stubBlocStream(mockThreadCubit,
          initialState: ThreadState.thread(fakeThread));

      await tester.pumpApp(MultiBlocProvider(
          providers: [
            BlocProvider<ChatBottomSheetCubit>(
              create: (_) => mockChatBottomSheetCubit,
            ),
            BlocProvider<ThreadCubit>(
              create: (_) => mockThreadCubit,
            )
          ],
          child: Builder(
              builder: (context) => ChatTitle(chatProviderContext: context))));

      expect(find.text(fakeThread.name), findsOneWidget);

      threadController.add(ThreadState.thread(secondThread));
      await tester.pump(const Duration(milliseconds: 10));

      expect(find.text(secondThread.name), findsOneWidget);
    });

    testWidgets('should flip when bottom sheet opens', (tester) async {
      final chatBottomSheetCubitController =
          stubBlocStream(mockChatBottomSheetCubit, initialState: false);

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.thread(fakeThread));

      await tester.pumpApp(MultiBlocProvider(
          providers: [
            BlocProvider<ChatBottomSheetCubit>(
              create: (_) => mockChatBottomSheetCubit,
            ),
            BlocProvider<ThreadCubit>(
              create: (_) => mockThreadCubit,
            )
          ],
          child: Builder(
              builder: (context) => ChatTitle(chatProviderContext: context))));

      expect(tester.widget<FlippableIcon>(find.byType(FlippableIcon)).flipped,
          false);

      chatBottomSheetCubitController.add(true);

      await tester.pump(FlippableIcon.FLIP_DURATION * 2);

      expect(tester.widget<FlippableIcon>(find.byType(FlippableIcon)).flipped,
          true);
    });
  });
}
