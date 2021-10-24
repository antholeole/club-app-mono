import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/club_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/selected_tab_indicator.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../test_helpers/pump_app.dart';

void main() {
  final MainCubit mockMainCubit = MockMainCubit.getMock();
  final Club fakeClub =
      Club(id: UuidType.generate(), name: 'fake club', admin: false);
  final Club otherFakeClub =
      Club(id: UuidType.generate(), name: 'fake club 2', admin: false);

  Widget build({required Widget child}) {
    return BlocProvider<MainCubit>(
      create: (context) => mockMainCubit,
      child: child,
    );
  }

  testWidgets('should display selected if selected', (tester) async {
    when(() => mockMainCubit.state).thenReturn(MainState.withClub(fakeClub));

    await tester.pumpApp(build(
        child: Column(
      children: [
        Provider(create: (_) => fakeClub, child: const ClubTab()),
        Provider(create: (_) => otherFakeClub, child: const ClubTab()),
      ],
    )));

    int selectedCount = 0;
    find
        .byType(SelectedTabIndicator)
        .evaluate()
        .map((e) => e.widget)
        .whereType<SelectedTabIndicator>()
        .forEach((element) {
      if (element.selected) {
        selectedCount++;
      }
    });

    expect(selectedCount, 1);
  });

  testWidgets('should switch group if tapped', (tester) async {
    when(() => mockMainCubit.state).thenReturn(MainState.withClub(fakeClub));

    await tester.pumpApp(build(
      child: Provider(create: (_) => fakeClub, child: const ClubTab()),
    ));

    await tester.tap(find.byType(ClubTab));

    verify(() => mockMainCubit.setClub(fakeClub)).called(1);
  });
}
