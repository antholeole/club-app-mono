import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/groups/view/widgets/group_settings.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/fixtures/mocks.dart';
import '../../../../test_helpers/get_it_helpers.dart';
import '../../../../test_helpers/pump_app.dart';
import '../../../../test_helpers/reset_mock_bloc.dart';
import '../../../../test_helpers/stub_gql_response.dart';

void main() {
  MockUpdateGroupsCubit mockUpdateGroupsCubit = MockUpdateGroupsCubit.getMock();
  MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

  const String failureMessage = 'asdasda';

  final fakeGroup = Group(
      id: UuidType('25bf07c0-c24a-4c27-a739-ba1039a711a8'),
      name: 'group name',
      admin: false);

  Widget wrapWithDependencies(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToasterCubit>(
          create: (_) => mockToasterCubit,
        ),
        BlocProvider<UpdateGroupsCubit>(
          create: (_) => mockUpdateGroupsCubit,
        ),
      ],
      child: child,
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeUuidType());
  });

  setUp(() {
    registerAllMockServices();

    resetMockBloc(mockUpdateGroupsCubit);
    resetMockBloc(mockToasterCubit);
  });

  group('group settings', () {
    testWidgets('should not display join token on not admin', (tester) async {
      whenListen(
          mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
          initialState: UpdateGroupsState.fetched({}));

      stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
          getIt<AuthGqlClient>(),
          data: (_) => GQueryUsersInGroupData.fromJson({'user_to_group': []})!);

      await tester.pumpApp(wrapWithDependencies(GroupSettings(
          group: GroupsPageGroup(
              group: fakeGroup,
              leaveState: LeavingState.notLeaving(),
              joinTokenState: JoinTokenState.notAdmin()))));
      await tester.pumpAndSettle();

      expect(find.text(GroupSettings.JOIN_TOKEN_HEADER), findsNothing);
    });

    group('leave group', () {
      testWidgets('calling leave group accepted callback should toast',
          (tester) async {
        when(() => mockUpdateGroupsCubit.leaveGroup(any(), any()))
            .thenAnswer((invocation) async {
          invocation.positionalArguments[1]();
        });

        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            data: (_) =>
                GQueryUsersInGroupData.fromJson({'user_to_group': []})!);

        whenListen(mockToasterCubit, Stream<ToasterState>.fromIterable([]));

        whenListen(
            mockUpdateGroupsCubit,
            Stream<UpdateGroupsState>.fromIterable([
              UpdateGroupsState.fetched({
                fakeGroup.id: GroupsPageGroup(
                    group: fakeGroup,
                    joinTokenState: JoinTokenState.notAdmin(),
                    leaveState: LeavingState.notLeaving()),
              })
            ]),
            initialState: UpdateGroupsState.fetched({}));

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group: fakeGroup,
                leaveState: LeavingState.notLeaving(),
                joinTokenState: JoinTokenState.notAdmin()))));
        await tester.tap(find.text(GroupSettings.LEAVE_GROUP));
        await tester.pumpAndSettle();

        verify(() => mockToasterCubit.add(any(
            that: isA<Toast>()
                .having((toast) => toast.message,
                    'messsage contains left group', contains('Left group'))
                .having((toast) => toast.type, 'type is success',
                    ToastType.Success)))).called(1);
      });

      testWidgets('should toast on leave group prompting', (tester) async {
        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            data: (_) =>
                GQueryUsersInGroupData.fromJson({'user_to_group': []})!);

        whenListen(mockToasterCubit, Stream<ToasterState>.fromIterable([]));

        whenListen(
            mockUpdateGroupsCubit,
            Stream<UpdateGroupsState>.fromIterable([
              UpdateGroupsState.fetched({
                fakeGroup.id: GroupsPageGroup(
                    group: fakeGroup,
                    joinTokenState: JoinTokenState.notAdmin(),
                    leaveState: LeavingState.prompting(
                        accepted: () async {}, rejected: () {})),
              })
            ]),
            initialState: UpdateGroupsState.fetched({}));

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group: fakeGroup,
                leaveState: LeavingState.notLeaving(),
                joinTokenState: JoinTokenState.notAdmin()))));

        await tester.pumpAndSettle();
        tester.binding.scheduleFrame();

        verify(() => mockToasterCubit.add(any(
            that: isA<Toast>()
                .having((toast) => toast.message, 'message',
                    contains(fakeGroup.name))
                .having((toast) => toast.action, 'action', isNotNull))));
      });

      testWidgets('should toast error on leave group failed', (tester) async {
        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            error: (_) => const Failure(
                status: FailureStatus.GQLMisc, message: failureMessage));

        whenListen(mockToasterCubit, Stream<ToasterState>.fromIterable([]));

        whenListen(
            mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
            initialState: UpdateGroupsState.fetched({
              fakeGroup.id: GroupsPageGroup(
                  group: fakeGroup,
                  joinTokenState: JoinTokenState.notAdmin(),
                  leaveState: LeavingState.notLeaving()),
            }));

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group: fakeGroup,
                leaveState: LeavingState.notLeaving(),
                joinTokenState: JoinTokenState.notAdmin()))));

        await tester.pumpAndSettle();
        tester.binding.scheduleFrame();

        verify(() => getIt<Handler>().handleFailure(any(), any(),
            toast: any(named: 'toast'),
            withPrefix: any(named: 'withPrefix'))).called(1);
      });
    });

    group('join token', () {
      const initalFakeJoinToken = 'asdasdasdinitalfaketoen';

      setUp(() {
        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            data: (_) =>
                GQueryUsersInGroupData.fromJson({'user_to_group': []})!);

        whenListen(
            mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
            initialState: UpdateGroupsState.fetched({}));
      });

      testWidgets('should display join token on admin', (tester) async {
        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState:
                    JoinTokenState.adminWithToken(initalFakeJoinToken),
                leaveState: LeavingState.notLeaving()))));

        await tester.pumpAndSettle();

        expect(find.text(initalFakeJoinToken), findsOneWidget);
      });

      testWidgets('should none on admin but no join token', (tester) async {
        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState: JoinTokenState.adminWithToken(null),
                leaveState: LeavingState.notLeaving()))));

        await tester.pumpAndSettle();

        expect(find.text(GroupSettings.NO_JOIN_TOKEN_TEXT), findsOneWidget);
      });

      testWidgets('should delete join token on click remove', (tester) async {
        when(() => mockUpdateGroupsCubit.updateGroupJoinToken(any(),
                delete: any(named: 'delete')))
            .thenAnswer((invocation) async => null);

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState:
                    JoinTokenState.adminWithToken(initalFakeJoinToken),
                leaveState: LeavingState.notLeaving()))));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        verify(() => mockUpdateGroupsCubit.updateGroupJoinToken(fakeGroup.id,
            delete: true)).called(1);
      });

      testWidgets(
          'should attempt to create new join token on join token refresh',
          (tester) async {
        when(() => mockUpdateGroupsCubit.updateGroupJoinToken(any(),
                delete: any(named: 'delete')))
            .thenAnswer((invocation) async => null);

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState:
                    JoinTokenState.adminWithToken(initalFakeJoinToken),
                leaveState: LeavingState.notLeaving()))));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pumpAndSettle();

        verify(() => mockUpdateGroupsCubit.updateGroupJoinToken(fakeGroup.id))
            .called(1);
      });
    });

    group('user display', () {
      testWidgets('should display info for every user', (tester) async {
        final usernames = ['Anthony', 'Yu Ming'];

        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GQueryUsersInGroupData.fromJson({
                  'user_to_group': [
                    {
                      'user': {
                        'name': usernames[0],
                        'profile_picture': null,
                        'id': '04c9b164-8535-4ae0-a091-9681a425b935'
                      }
                    },
                    {
                      'user': {
                        'name': usernames[1],
                        'profile_picture': null,
                        'id': '97f2c291-7449-4430-a47b-275d99ebdb0e'
                      }
                    }
                  ]
                })!);

        whenListen(
            mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
            initialState: UpdateGroupsState.fetched({}));

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState: JoinTokenState.adminWithToken(null),
                leaveState: LeavingState.notLeaving()))));

        await tester.pumpAndSettle();

        usernames
            .forEach((username) => expect(find.text(username), findsOneWidget));
      });

      testWidgets('should display error on error fetching users',
          (tester) async {
        stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
            getIt<AuthGqlClient>(),
            error: (_) => const Failure(
                status: FailureStatus.GQLMisc, message: failureMessage));

        when(() => getIt<Handler>().basicGqlErrorHandler(any())).thenAnswer(
            (_) async => const Failure(status: FailureStatus.GQLMisc));

        whenListen(
            mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
            initialState: UpdateGroupsState.fetched({}));

        whenListen(mockToasterCubit, Stream<ToasterState>.fromIterable([]),
            initialState: ToasterState());

        await tester.pumpApp(wrapWithDependencies(GroupSettings(
            group: GroupsPageGroup(
                group:
                    Group(admin: true, id: fakeGroup.id, name: fakeGroup.name),
                joinTokenState: JoinTokenState.adminWithToken(null),
                leaveState: LeavingState.notLeaving()))));

        await tester.pumpAndSettle();

        expect(find.text(GroupSettings.ERROR_LOADING_USERS), findsOneWidget);
      });
    });
  });
}
