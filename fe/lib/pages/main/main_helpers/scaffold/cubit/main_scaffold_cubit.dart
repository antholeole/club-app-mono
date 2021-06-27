import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'main_scaffold_state.dart';
part 'data_carriers.dart';

class MainScaffoldCubit extends Cubit<MainScaffoldState> {
  MainScaffoldCubit() : super(MainScaffoldInitial());

  void updateMainScaffold(MainScaffoldUpdate update) => emit(update);
}
