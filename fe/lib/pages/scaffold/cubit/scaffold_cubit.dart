import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'data_carriers/main_scaffold_parts.dart';

part 'scaffold_state.dart';

class ScaffoldCubit extends Cubit<ScaffoldState> {
  ScaffoldCubit() : super(const ScaffoldInitial());

  void updateMainParts(MainScaffoldParts parts) => emit(ScaffoldUpdate(parts));
}
