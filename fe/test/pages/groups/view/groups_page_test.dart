import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/groups/view/groups_page.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.var.gql.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.data.gql.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final UuidType userId = UuidType('3ba1c8b5-e1d0-4c0b-ba9d-1a96bfd4fb04');

  const String groupName = 'groupname';
  final UuidType groupId = UuidType('213499b5-54bd-4245-9bf9-9245cc7daafa');

  const String failureMessage = 'what happened bro';

  setUp(() {
    registerAllMockServices(needCubitAutoEvents: true);

    when(() => getIt<LocalUserService>().getLoggedInUserId())
        .thenAnswer((_) async => userId);
  });
  group('groups page', () {
    testWidgets('should render groupsView', (tester) async {
      stubGqlResponse<GQueryAllGroupsConditionalJoinTokenData,
              GQueryAllGroupsConditionalJoinTokenVars>(getIt<AuthGqlClient>(),
          data: (_) => GQueryAllGroupsConditionalJoinTokenData.fromJson({
                'member_groups': [
                  {
                    'group': {
                      'group_name': groupName,
                      'id': groupId.toString(),
                    }
                  }
                ]
              })!);

      await tester.pumpApp(const GroupsPage());

      expect(find.byType(GroupsView), findsOneWidget);
    });
  });

  group('groups view', () {
    MockUpdateGroupsCubit mockUpdateGroupsCubit =
        MockUpdateGroupsCubit.getMock();
    MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

    Widget wrapWithDependencies(Widget child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<UpdateGroupsCubit>(
            create: (context) => mockUpdateGroupsCubit,
          ),
          BlocProvider<ToasterCubit>(
            create: (context) => mockToasterCubit,
          ),
        ],
        child: child,
      );
    }

    setUp(() {
      resetMockCubit(mockUpdateGroupsCubit);
      resetMockCubit(mockToasterCubit);

      whenListen(
        mockToasterCubit,
        Stream<ToasterState>.fromIterable([]),
        initialState: ToasterState(),
      );
    });

    testWidgets(
        'should gracefully handle error by toasting and displaying error',
        (tester) async {
      whenListen(
          mockUpdateGroupsCubit,
          Stream<UpdateGroupsState>.fromIterable([
            UpdateGroupsState.failure(const Failure(
                status: FailureStatus.Unknown, message: failureMessage))
          ]),
          initialState: UpdateGroupsState.fetchingGroups());

      await tester.pumpApp(wrapWithDependencies(GroupsView()));

      tester.binding.scheduleFrame();
      await tester.pumpAndSettle();

      expect(find.text(GroupsView.ERROR_TEXT), findsOneWidget);
      verify(() => getIt<Handler>().handleFailure(any(), any(),
          toast: any(named: 'toast'),
          withPrefix: any(named: 'withPrefix'))).called(1);
    });

    testWidgets('should display no clubs on no clubs', (tester) async {
      whenListen(
          mockUpdateGroupsCubit,
          Stream<UpdateGroupsState>.fromIterable(
              [UpdateGroupsState.fetched({})]),
          initialState: UpdateGroupsState.fetchingGroups());

      await tester.pumpApp(wrapWithDependencies(GroupsView()));
      await tester.pumpAndSettle();

      expect(find.text(GroupsView.NO_CLUBS_TEXT), findsOneWidget);
    });

    testWidgets('should display clubs on clubs', (tester) async {
      final mockMainCubit = MockMainCubit.getMock();
      final group = Group(admin: false, id: groupId, name: groupName);

      stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
          getIt<AuthGqlClient>(),
          data: (_) => GQueryUsersInGroupData.fromJson({'user_to_group': []})!);

      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withGroup(group));

      whenListen(
          mockUpdateGroupsCubit,
          Stream<UpdateGroupsState>.fromIterable([
            UpdateGroupsState.fetched({
              groupId: GroupsPageGroup(
                  group: group,
                  joinTokenState: JoinTokenState.notAdmin(),
                  leaveState: LeavingState.notLeaving())
            })
          ]),
          initialState: UpdateGroupsState.fetchingGroups());

      await tester.pumpApp(BlocProvider<MainCubit>(
        create: (_) => mockMainCubit,
        child: wrapWithDependencies(GroupsView()),
      ));
      await tester.pumpAndSettle();

      expect(find.text(groupName), findsOneWidget);
    });
  });
}
