import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';

StreamController<S> stubBlocStream<S>(BlocBase<S> mockCubit,
    {S? initialState}) {
  final cubitController = StreamController<S>.broadcast();

  whenListen(
    mockCubit,
    cubitController.stream,
    initialState: initialState,
  );

  return cubitController;
}
