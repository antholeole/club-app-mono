part of 'main_page_actions_cubit.dart';

class Logout extends MainPageActionsState {
  bool withError;

  Logout({required this.withError});
}

class MainPageActionsInitial extends MainPageActionsState {
  @override
  String? subtitle;
  @override
  Widget? endDrawer;
}

abstract class MainPageActionsState {
  Widget? endDrawer;
  String? subtitle;

  MainPageActionsState({this.endDrawer, this.subtitle});
}

class ScaffoldUpdate extends MainPageActionsState {
  ScaffoldUpdate({Widget? endDrawer, String? subtitle})
      : super(endDrawer: endDrawer, subtitle: subtitle);
}
