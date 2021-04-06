import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

part 'hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  var box;

  HiveCubit() : super(HiveInitial());

  void addBox(Box box) => emit(HiveSetup(box: box));
}
