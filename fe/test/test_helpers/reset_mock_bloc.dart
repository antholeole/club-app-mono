import 'package:bloc/bloc.dart';
import 'package:mocktail/mocktail.dart';

void resetMockBloc(BlocBase mockBloc) {
  reset(mockBloc);
  when(() => mockBloc.close()).thenAnswer((invocation) async => null);
}
