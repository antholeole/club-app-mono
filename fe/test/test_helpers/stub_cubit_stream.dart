import 'dart:async';

import 'package:bloc_test/bloc_test.dart';

StreamController<S> stubCubitStream<S>(MockCubit<S> mockCubit,
    {S? initialState}) {
  final cubitController = StreamController<S>.broadcast();

  whenListen(
    mockCubit,
    cubitController.stream,
    initialState: initialState,
  );

  return cubitController;
}
