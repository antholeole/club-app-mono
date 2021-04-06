part of 'hive_cubit.dart';

abstract class HiveState {
  late Box box;

  HiveState();
}

class HiveInitial extends HiveState {}

class HiveSetup extends HiveState {
  @override
  Box box;

  HiveSetup({required this.box});
}
