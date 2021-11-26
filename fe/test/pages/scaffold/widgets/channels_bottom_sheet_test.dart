import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_view_only_threads.req.gql.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/channels_bottom_sheet.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../test_helpers/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  group('channels bottom sheet', () {
    final Club fakeAdminGroup =
        Club(name: 'asdasddss', id: UuidType.generate(), admin: true);
    final Club fakeNotAdminGroup =
        Club(name: 'asdasddss', id: UuidType.generate(), admin: false);
    final User fakeUser =
        User(id: UuidType.generate(), name: 'ant', profilePictureUrl: 'asasd');

    MockMainCubit mockMainCubit = MockMainCubit.getMock();
    MockChatBottomSheetCubit mockChatBottomSheetCubit =
        MockChatBottomSheetCubit.getMock();
    MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
    MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

    Widget build() {
      return MultiProvider(
          providers: [
            BlocProvider(create: (_) => UserCubit(fakeUser)),
            BlocProvider<MainCubit>(create: (_) => mockMainCubit),
            BlocProvider<ChatBottomSheetCubit>(
              create: (_) => mockChatBottomSheetCubit,
            ),
            BlocProvider<ThreadCubit>(
              create: (_) => mockThreadCubit,
            ),
            BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
          ],
          builder: (context, _) =>
              ChannelsBottomSheet(providerReadableContext: context));
    }

    setUp(() async {
      resetMockBloc(mockMainCubit);
      resetMockBloc(mockThreadCubit);
      resetMockBloc(mockChatBottomSheetCubit);

      await registerAllMockServices();

      whenListen(mockChatBottomSheetCubit, Stream<bool>.fromIterable([]),
          initialState: false);

      whenListen(mockThreadCubit, Stream<ThreadState>.fromIterable([]),
          initialState: ThreadState.noThread());
    });

    group('with admin group', () {
      setUp(() {
        whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
            initialState: MainState.withClub(fakeAdminGroup));
      });
    });

    group('with not admin', () {
      setUp(() {
        whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
            initialState: MainState.withClub(fakeNotAdminGroup));
      });

      testWidgets(
          'should gracefully handle error by toasting and showing message',
          (tester) async {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            error: (_) => Failure(status: FailureStatus.GQLMisc));

        await tester.pumpApp(build());

        await tester.pump(const Duration(milliseconds: 10));

        tester.binding.scheduleFrame();
        await tester.pump();

        expect(find.text(ChannelsBottomSheet.ERROR_TEXT), findsOneWidget);

        verify(() => getIt<Handler>().handleFailure(any(), any(),
            withPrefix: any(named: 'withPrefix'),
            toast: any(named: 'toast'))).called(1);
      });

      testWidgets('should display all threads', (tester) async {
        const thread1Name = 'thread one';
        const thread2Name = 'thread two';
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                  'threads': [
                    {
                      'name': thread1Name,
                      'id': '348af35f-4444-494b-a980-c0a420384c61'
                    },
                    {
                      'name': thread2Name,
                      'id': '3481f35f-e444-494b-a980-c0a420384c61'
                    }
                  ]
                })!,
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>());

        await tester.pumpApp(build());
        await tester.pump();
        await expectLater(find.text(thread1Name), findsOneWidget);
        await expectLater(find.text(thread2Name), findsOneWidget);
      });

      testWidgets('should not query view only groups', (tester) async {
        stubGqlResponse<GQuerySelfThreadsInGroupData,
                GQuerySelfThreadsInGroupVars>(getIt<AuthGqlClient>(),
            data: (_) => GQuerySelfThreadsInGroupData.fromJson({})!,
            requestMatcher: isA<GQuerySelfThreadsInGroupReq>());

        await tester.pumpApp(build());
        await tester.pump();

        verifyNever(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GQueryViewOnlyThreadsReq>())));
      });

      testWidgets('should say no group on no group', (tester) async {
        resetMockBloc(mockMainCubit);
        whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
            initialState: MainState.groupless());

        await tester.pumpApp(build());
        await tester.pumpAndSettle();

        expect(find.text(ChannelsBottomSheet.NO_GROUP), findsOneWidget);
      });
    });
  });
}
