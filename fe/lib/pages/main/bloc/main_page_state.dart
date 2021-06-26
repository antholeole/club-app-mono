part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {
  const MainPageState();
}

class MainPageInitial extends MainPageState {
  const MainPageInitial();
}

class MainPageLoading extends MainPageState {
  const MainPageLoading();
}

class MainPageLoadFailure extends MainPageState {
  final Failure failure;

  const MainPageLoadFailure({required this.failure});
}

class MainPageGroupless extends MainPageState {
  const MainPageGroupless();
}

class MainPageWithGroup extends MainPageState {
  final Group group;

  const MainPageWithGroup({required this.group});
}
