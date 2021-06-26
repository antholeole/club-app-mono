part of 'main_page_actions_cubit.dart';

abstract class MainPageActionsState {
  Group? selectedGroup;

  MainPageActionsState({this.selectedGroup});
}

class MainPageActionsInitial extends MainPageActionsState {}

class SelectGroup extends MainPageActionsState {
  SelectGroup({required Group selectedGroup})
      : super(selectedGroup: selectedGroup);
}

class Logout extends MainPageActionsState {
  bool withError;

  Logout({required this.withError});
}
