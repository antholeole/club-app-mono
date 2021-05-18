part of 'main_page_actions_cubit.dart';

class SelectGroup extends MainPageActionsState {
  SelectGroup({required UuidType selectedGroupId})
      : super(selectedGroupId: selectedGroupId);
}

class Logout extends MainPageActionsState {
  bool withError;

  Logout({required this.withError});
}

class ResetPage extends MainPageActionsState {}

class MainPageActionsInitial extends MainPageActionsState {}

abstract class MainPageActionsState {
  UuidType? selectedGroupId;

  MainPageActionsState({this.selectedGroupId});
}
