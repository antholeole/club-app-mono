import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'scaffold_update_state.dart';

class ScaffoldUpdateCubit extends Cubit<ScaffoldUpdateState> {
  ScaffoldUpdateCubit() : super(ScaffoldUpdateInitial());

  void updateScaffold(Widget? drawer, String? subtitle) =>
      emit(ScaffoldUpdate(endDrawer: drawer, subtitle: subtitle));
}
