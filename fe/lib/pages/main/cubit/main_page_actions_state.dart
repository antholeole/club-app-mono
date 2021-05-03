part of 'main_page_actions_cubit.dart';

class SelectGroup extends MainPageActionsState {
  SelectGroup({required Group selectedGroup})
      : super(selectedGroup: selectedGroup);
}

class Logout extends MainPageActionsState {
  bool withError;

  Logout({required this.withError});
}

class MainPageActionsInitial extends MainPageActionsState {}

abstract class MainPageActionsState {
  Group? selectedGroup;

  MainPageActionsState({this.selectedGroup});
}
