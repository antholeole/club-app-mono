import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';

void patchCubitClose(MockCubit mockCubit) {
  when(() => mockCubit.close()).thenAnswer((invocation) async => null);
}
