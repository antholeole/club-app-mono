import 'package:fe/data/models/dm.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/dm/dm_tab.dart';
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
  final Dm fakeDm = Dm(id: UuidType.generate(), users: [], name: 'asdasd');
  final Dm otherDm = Dm(id: UuidType.generate(), name: 'toast', users: []);

  Widget build({required Widget child}) {
    when(() => mockMainCubit.state).thenReturn(MainState.withDm(dm: fakeDm));

    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(create: (_) => mockMainCubit),
      ],
      child: child,
    );
  }

  testWidgets('should display selectedTabIncidactor if selected',
      (tester) async {
    await tester.pumpApp(build(
        child: Column(
      children: [
        Provider(create: (_) => fakeDm, child: const DmTab()),
        Provider(create: (_) => otherDm, child: const DmTab()),
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

  testWidgets('should set dm on tap', (tester) async {
    await tester.pumpApp(
        build(child: Provider(create: (_) => fakeDm, child: const DmTab())));

    await tester.tap(find.byType(DmTab));

    verify(() => mockMainCubit.setDm(fakeDm)).called(1);
  });
}
