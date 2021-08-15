import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

void resetMockCubit(MockCubit mockBloc) {
  reset(mockBloc);
  when(() => mockBloc.close()).thenAnswer((invocation) async => null);
}
