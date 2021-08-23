import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/groups/view/widgets/group_settings.dart';
import 'package:fe/pages/groups/view/widgets/group_tab.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:ferry/ferry.dart';
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
  final mockMainCubit = MockMainCubit.getMock();
  final mockUpdateGroupsCubit = MockUpdateGroupsCubit.getMock();

  final fakeGroupPageGroup = GroupsPageGroup(
      group: Group(id: UuidType.generate(), name: 'fake', admin: false),
      joinTokenState: JoinTokenState.notAdmin(),
      leaveState: LeavingState.notLeaving());

  setUp(() {
    registerAllMockServices(needCubitAutoEvents: true);
    resetMockCubit(mockMainCubit);
    resetMockCubit(mockUpdateGroupsCubit);
  });

  Widget wrapWithDependencies(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (_) => mockMainCubit,
        ),
        BlocProvider<UpdateGroupsCubit>(
          create: (_) => mockUpdateGroupsCubit,
        ),
      ],
      child: child,
    );
  }

  void stubEmpty() {
    whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
        initialState: MainState.withGroup(fakeGroupPageGroup.group));

    whenListen(
        mockUpdateGroupsCubit, Stream<UpdateGroupsState>.fromIterable([]),
        initialState: UpdateGroupsState.fetched(
            {fakeGroupPageGroup.group.id: fakeGroupPageGroup}));

    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<Client>(),
        data: (_) => GQueryUsersInGroupData.fromJson({'user_to_group': []})!);
  }

  group('group tab', () {
    testWidgets('should display group name', (tester) async {
      stubEmpty();

      await tester
          .pumpApp(wrapWithDependencies(GroupTab(group: fakeGroupPageGroup)));

      expect(find.text(fakeGroupPageGroup.group.name), findsOneWidget);
    });

    testWidgets('should not display groups settings by default',
        (tester) async {
      stubEmpty();

      await tester
          .pumpApp(wrapWithDependencies(GroupTab(group: fakeGroupPageGroup)));

      expect(find.byType(GroupSettings), findsNothing);
    });

    testWidgets('should reveal groups settings on click', (tester) async {
      stubEmpty();

      await tester
          .pumpApp(wrapWithDependencies(GroupTab(group: fakeGroupPageGroup)));
      await tester.tap(find.byType(FlippableIcon));
      await tester.pumpAndSettle();

      expect(find.byType(GroupSettings), findsOneWidget);
    });

    testWidgets('should hide groups settings on double click', (tester) async {
      stubEmpty();

      await tester
          .pumpApp(wrapWithDependencies(GroupTab(group: fakeGroupPageGroup)));
      await tester.tap(find.byType(FlippableIcon));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FlippableIcon));
      await tester.pumpAndSettle();

      expect(find.byType(GroupSettings), findsNothing);
    });

    testWidgets('should switch groups on tap', (tester) async {
      stubEmpty();

      await tester
          .pumpApp(wrapWithDependencies(GroupTab(group: fakeGroupPageGroup)));

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      verify(() => mockMainCubit.setGroup(fakeGroupPageGroup.group)).called(1);
    });
  });
}
