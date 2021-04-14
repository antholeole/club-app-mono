import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'main_page_actions_state.dart';

class MainPageActionsCubit extends Cubit<MainPageActionsState> {
  MainPageActionsCubit() : super(MainPageActionsInitial());

  void logout({bool withError = false}) => emit(Logout(withError: withError));

  void updateScaffold(Widget? drawer, String? subtitle) =>
      emit(ScaffoldUpdate(endDrawer: drawer, subtitle: subtitle));
}
