import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/group.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  group('channels bottom sheet', () {
    final User fakeUser =
        User(id: UuidType.generate(), name: 'ant', profilePictureUrl: 'asasd');
    const Key showBottomSheetButtonKey = Key('show-bottom-sheet-button-key');
    const Key dismisserKey = Key('dismisser-key');

    MockMainCubit mockMainCubit = MockMainCubit.getMock();
    MockChatBottomSheetCubit mockChatBottomSheetCubit =
        MockChatBottomSheetCubit.getMock();
    MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
    MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

    Widget build() {
      return UserProvider(
          user: fakeUser,
          child: MultiBlocProvider(
              providers: [
                BlocProvider<MainCubit>(create: (_) => mockMainCubit),
                BlocProvider<ChatBottomSheetCubit>(
                  create: (_) => mockChatBottomSheetCubit,
                ),
                BlocProvider<ThreadCubit>(
                  create: (_) => mockThreadCubit,
                ),
                BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
              ],
              child: MaterialApp(
                home: Scaffold(
                  body: Column(
                    children: [
                      Container(width: 10, height: 10, key: dismisserKey),
                      Container(
                        height: 10,
                        width: 10,
                        child: Builder(
                            builder: (context) => GestureDetector(
                                key: showBottomSheetButtonKey,
                                onTap: () =>
                                    ChannelsBottomSheet.show(context))),
                      ),
                    ],
                  ),
                ),
              )));
    }

    Future<void> cleanUp(WidgetTester tester) async {
      await tester.tap(find.byKey(dismisserKey),
          warnIfMissed: false); // any widget that isn't in the bottom sheet
      await tester.pumpAndSettle();
    }

    Future<void> show(WidgetTester tester) async {
      await tester.tap(find.byKey(showBottomSheetButtonKey));
      await tester.pump(const Duration(milliseconds: 10));
    }

    setUp(() async {
      resetMockCubit(mockMainCubit);
      resetMockCubit(mockThreadCubit);
      resetMockCubit(mockChatBottomSheetCubit);

      await registerAllServices();

      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withGroup(mockGroupAdmin));

      whenListen(mockChatBottomSheetCubit,
          Stream<ChatBottomSheetState>.fromIterable([]),
          initialState: const ChatBottomSheetState(isOpen: false));

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.noThread());
    });

    testWidgets('should add open to chatBottomSheetCubit on show',
        (tester) async {
      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<Client>(),
          data: (_) =>
              GQuerySelfThreadsInGroupData.fromJson({'group_threads': []})!);

      await tester.pumpApp(build());
      await show(tester);

      verify(() => mockChatBottomSheetCubit.setState(true)).called(1);

      await cleanUp(tester);
    });

    testWidgets('should add close to chatBottomSheetCubit on dismiss',
        (tester) async {
      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<Client>(),
          data: (_) =>
              GQuerySelfThreadsInGroupData.fromJson({'group_threads': []})!);

      await tester.pumpApp(build());
      await show(tester);
      await cleanUp(tester);

      verify(() => mockChatBottomSheetCubit.setState(false)).called(1);
    });

    testWidgets(
        'should gracefully handle error by toasting and showing message',
        (tester) async {
      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<Client>(),
          errors: (_) => [const GraphQLError(message: 'fake')]);

      await tester.pumpWidget(build());
      await show(tester);

      await tester.pump(const Duration(milliseconds: 10));

      tester.binding.scheduleFrame();
      await tester.pump();

      debugDumpApp();

      expect(find.text(ChannelsBottomSheet.ERROR_TEXT), findsOneWidget);

      verify(() => mockToasterCubit.add(any(
              that: isA<Toast>()
                  .having((toast) => toast.message, 'message',
                      contains(ChannelsBottomSheet.ERROR_TEXT))
                  .having(
                      (toast) => toast.type, 'type', equals(ToastType.Error)))))
          .called(1);

      await cleanUp(tester);
    });

    testWidgets('should display all threads', (tester) async {
      const thread1Name = 'thread one';
      const thread2Name = 'thread two';
      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<Client>(),
          data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                'group_threads': [
                  {
                    'name': thread1Name,
                    'id': '348af35f-4444-494b-a980-c0a420384c61'
                  },
                  {
                    'name': thread2Name,
                    'id': '3481f35f-e444-494b-a980-c0a420384c61'
                  }
                ]
              })!);

      await tester.pumpWidget(build());
      await show(tester);
      await tester.pump();

      await expectLater(find.text(thread1Name), findsOneWidget);
      await expectLater(find.text(thread2Name), findsOneWidget);

      await cleanUp(tester);
    });

    testWidgets('should switch to thread and close modal on tap thread',
        (tester) async {
      final fakeThread = Thread(name: 'han', id: UuidType.generate());

      stubGqlResponse<GQuerySelfThreadsInGroupData,
              GQuerySelfThreadsInGroupVars>(getIt<Client>(),
          data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                'group_threads': [
                  fakeThread.toJson(),
                  {
                    'name': 'fake name 2',
                    'id': '3481f35f-e444-494b-a980-c0a420384c61'
                  }
                ]
              })!);

      Future<Thread?> threadSelectedFuture = Future.value(null);

      await tester.pumpWidget(UserProvider(
          user: fakeUser,
          child: MultiBlocProvider(
              providers: [
                BlocProvider<MainCubit>(create: (_) => mockMainCubit),
                BlocProvider<ChatBottomSheetCubit>(
                  create: (_) => mockChatBottomSheetCubit,
                ),
                BlocProvider<ThreadCubit>(
                  create: (_) => mockThreadCubit,
                ),
                BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
              ],
              child: MaterialApp(
                home: Scaffold(
                  body: Column(
                    children: [
                      Container(width: 10, height: 10, key: dismisserKey),
                      Container(
                          height: 10,
                          width: 10,
                          child: Builder(
                            builder: (context) => GestureDetector(
                              key: showBottomSheetButtonKey,
                              onTap: () {
                                threadSelectedFuture =
                                    ChannelsBottomSheet.show(context);
                              },
                            ),
                          ))
                    ],
                  ),
                ),
              ))));

      await show(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.text(fakeThread.name));
      await tester.pumpAndSettle();

      expect(await threadSelectedFuture, equals(fakeThread));
      expect(find.text(ChannelsBottomSheet.CHANNELS_TEXT), findsNothing);
    });

    testWidgets('should say no group on no group', (tester) async {
      resetMockCubit(mockMainCubit);
      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.groupless());

      await tester.pumpWidget(build());
      await show(tester);
      await tester.pumpAndSettle();

      expect(find.text(ChannelsBottomSheet.NO_GROUP), findsOneWidget);

      await cleanUp(tester);
    });
  });
}
