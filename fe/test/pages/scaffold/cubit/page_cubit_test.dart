import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_state.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/channels_bottom_sheet.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  group('Page Cubit', () {
    blocTest<PageCubit, PageState>('switchTo should switch to proper page',
        build: () => PageCubit(),
        act: (cubit) {
          cubit.switchTo(AppPage.Chat);
          cubit.switchTo(AppPage.Events);
        },
        expect: () => [PageState.chatPage(), PageState.eventPage()]);

    group('bottom sheet', () {
      final fakeUser = User(id: UuidType.generate(), name: 'hann');
      final fakeGroup =
          Group(id: UuidType.generate(), name: 'group', admin: false);
      final fakeThread = Thread(name: 'fake thread', id: UuidType.generate());

      const notBottomSheetKey = Key('notbottomsheetlmfao');

      final mockChatBottomSheetCubit = MockChatBottomSheetCubit.getMock();
      final mockMainCubit = MockMainCubit.getMock();

      Future<BuildContext> getBottomSheetableContext(
          PageCubit cubit, WidgetTester tester) async {
        BuildContext? retContext;

        await tester.pumpApp(UserProvider(
          user: fakeUser,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MainCubit>(create: (_) => mockMainCubit),
              BlocProvider<ChatBottomSheetCubit>(
                create: (_) => mockChatBottomSheetCubit,
              ),
              BlocProvider(
                create: (_) => cubit,
              ),
            ],
            child: Builder(builder: (context) {
              retContext = context;
              return Container(
                key: notBottomSheetKey,
              );
            }),
          ),
        ));

        return retContext!;
      }

      setUp(() {
        resetMockBloc(mockChatBottomSheetCubit);
        registerAllMockServices();
      });

      testWidgets('should have selected thread if thread is selected',
          (tester) async {
        final mockThreadCubit = MockThreadCubit.getMock();

        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'group_threads': [
                    fakeThread.toJson(),
                    {
                      'name': 'thread2',
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!);

        whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
            initialState: false);
        whenListen(mockMainCubit, const Stream<MainState>.empty(),
            initialState: MainState.withGroup(fakeGroup));
        whenListen(mockThreadCubit, const Stream<ThreadState>.empty(),
            initialState: ThreadState.thread(fakeThread));

        final pageCubit = PageCubit()..addThreadCubit(mockThreadCubit);

        final context = await getBottomSheetableContext(pageCubit, tester);

        // cannot await here; will hang forever due to waiting for action.
        // ignore: unawaited_futures
        pageCubit.bottomSheet(context);
        await tester.pumpAndSettle();

        expect(
            tester
                .widget<ChannelsBottomSheet>(find.byType(ChannelsBottomSheet))
                .selectedThread,
            equals(fakeThread));
      });

      testWidgets('should not selected thread if no thread cubit',
          (tester) async {
        final mockThreadCubit = MockThreadCubit.getMock();

        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'group_threads': [
                    fakeThread.toJson(),
                    {
                      'name': 'thread2',
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!);

        whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
            initialState: false);
        whenListen(mockMainCubit, const Stream<MainState>.empty(),
            initialState: MainState.withGroup(fakeGroup));
        whenListen(mockThreadCubit, const Stream<ThreadState>.empty(),
            initialState: ThreadState.thread(fakeThread));

        final pageCubit = PageCubit()
          ..addThreadCubit(mockThreadCubit)
          ..removeThreadCubit();

        final context = await getBottomSheetableContext(pageCubit, tester);

        // cannot await here; will hang forever due to waiting for action.
        // ignore: unawaited_futures
        pageCubit.bottomSheet(context);
        await tester.pumpAndSettle();

        expect(
            tester
                .widget<ChannelsBottomSheet>(find.byType(ChannelsBottomSheet))
                .selectedThread,
            isNull);
      });

      testWidgets('should emit thread selected if thread selected',
          (tester) async {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'group_threads': [
                    fakeThread.toJson(),
                    {
                      'name': 'thread2',
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!);

        whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
            initialState: false);
        whenListen(mockMainCubit, const Stream<MainState>.empty(),
            initialState: MainState.withGroup(fakeGroup));

        final pageCubit = PageCubit();

        final context = await getBottomSheetableContext(pageCubit, tester);

        // cannot await here; will hang forever due to waiting for action.
        // ignore: unawaited_futures
        pageCubit.bottomSheet(context);
        await tester.pumpAndSettle();
        await tester.tap(find.text(fakeThread.name));
        await tester.pumpAndSettle();

        expect(
            pageCubit.state, equals(PageState.chatPage(toThread: fakeThread)));
      });

      testWidgets('should emit nothing if not thread selected', (tester) async {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'group_threads': [
                    fakeThread.toJson(),
                    {
                      'name': 'thread2',
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!);

        whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
            initialState: false);
        whenListen(mockMainCubit, const Stream<MainState>.empty(),
            initialState: MainState.withGroup(fakeGroup));

        final List<PageState> emittedStates = [];
        final pageCubit = PageCubit();

        pageCubit.stream.listen(emittedStates.add);

        final context = await getBottomSheetableContext(pageCubit, tester);

        // cannot await here; will hang forever due to waiting for action.
        // ignore: unawaited_futures
        pageCubit.bottomSheet(context);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(notBottomSheetKey), warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(emittedStates, isEmpty,
            reason: 'should not have emitted any states');
      });
    });
  });
}
