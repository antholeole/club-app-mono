part of 'main_page_actions_cubit.dart';

abstract class MainPageActionsState {
  Widget? endDrawer;
  String? subtitle;

  MainPageActionsState({this.endDrawer, this.subtitle});
}

class MainPageActionsInitial extends MainPageActionsState {
  @override
  String? subtitle;
  @override
  Widget? endDrawer;
}

class ScaffoldUpdate extends MainPageActionsState {
  ScaffoldUpdate({Widget? endDrawer, String? subtitle})
      : super(endDrawer: endDrawer, subtitle: subtitle);
}

class Logout extends MainPageActionsState {}
