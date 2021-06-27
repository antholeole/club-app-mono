part of 'main_scaffold_cubit.dart';

@immutable
abstract class MainScaffoldState {
  final Widget? titleBarWidget;
  final List<ActionButton> actionButtons;
  final Widget? endDrawer;

  const MainScaffoldState(
      {this.titleBarWidget, this.actionButtons = const [], this.endDrawer});
}

class MainScaffoldInitial extends MainScaffoldState {}

class MainScaffoldUpdate extends MainScaffoldState {
  const MainScaffoldUpdate(
      {Widget? titleBarWidget,
      List<ActionButton> actionButtons = const [],
      Widget? endDrawer})
      : super(
            actionButtons: actionButtons,
            titleBarWidget: titleBarWidget,
            endDrawer: endDrawer);
}
