import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/fixtures/key.dart';

void main() {
  group('Scaffold Cubit', () {
    blocTest<ScaffoldCubit, ScaffoldState>(
        'initalized with inital scaffold state',
        build: () => ScaffoldCubit(),
        verify: (cubit) =>
            expect(cubit.state, equals(const ScaffoldInitial())));

    blocTest<ScaffoldCubit, ScaffoldState>(
        'update main parts should emit scaffold update with parts',
        build: () => ScaffoldCubit(),
        act: (cubit) => cubit.updateMainParts(MainScaffoldParts(
                titleBarWidget: Container(
              key: testingKey,
            ))),
        verify: (cubit) => expect(
            cubit.state.mainScaffoldParts.titleBarWidget?.key,
            equals(testingKey)));
  });
}
