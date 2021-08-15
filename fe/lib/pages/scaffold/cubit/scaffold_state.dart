part of 'scaffold_cubit.dart';

@immutable
abstract class ScaffoldState {
  final MainScaffoldParts mainScaffoldParts;

  const ScaffoldState(this.mainScaffoldParts);
}

class ScaffoldInitial extends ScaffoldState {
  const ScaffoldInitial() : super(const MainScaffoldParts());
}

class ScaffoldUpdate extends ScaffoldState {
  const ScaffoldUpdate(MainScaffoldParts mainScaffoldParts)
      : super(mainScaffoldParts);
}
