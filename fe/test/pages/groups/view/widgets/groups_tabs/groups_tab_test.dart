import 'package:fe/data/models/dm.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/groups_tab.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../test_helpers/pump_app.dart';

void main() {
//should display no element text on no element

  testWidgets('should display header', (tester) async {
    const header = 'hi';

    await tester.pumpApp(GroupsTab<Dm>(
      groups: [],
      buildTab: () => Container(),
      header: header,
      noElementsText: '',
    ));

    expect(find.text(header), findsOneWidget);
  });

  testWidgets('should call build tab for every group', (tester) async {
    const numOfTabs = 6;
    final caller = MockCaller();

    await tester.pumpApp(GroupsTab<Dm>(
      groups: List.filled(
          numOfTabs, Dm(id: UuidType.generate(), users: [], name: 'asdas')),
      buildTab: () {
        caller.call();
        return Container();
      },
      header: 'hi',
      noElementsText: '',
    ));

    verify(() => caller.call()).called(numOfTabs);
  });

  testWidgets('should display no element text on no element', (tester) async {
    const noElementText = 'asdaopsjdoaisjdoiasjdio';

    await tester.pumpApp(GroupsTab<Dm>(
      groups: [],
      buildTab: () => Container(),
      header: 'hi',
      noElementsText: noElementText,
    ));

    expect(find.text(noElementText), findsOneWidget);
  });
}
