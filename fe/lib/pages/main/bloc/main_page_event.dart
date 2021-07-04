part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {
  const MainPageEvent();
}

class ResetMainPageEvent extends MainPageEvent {}

class SetGroupEvent extends MainPageEvent {
  final Group group;

  const SetGroupEvent({required this.group});
}

class ManualAddDataEvent extends MainPageEvent {
  final GQuerySelfGroupsPreviewData data;

  const ManualAddDataEvent({required this.data});
}
