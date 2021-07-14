import 'package:bloc/bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/main_scaffold_parts.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'scaffold_state.dart';

class ScaffoldCubit extends Cubit<ScaffoldState> {
  ScaffoldCubit() : super(const ScaffoldInitial());

  void updateMainParts(MainScaffoldParts parts) => emit(ScaffoldUpdate(parts));
}
