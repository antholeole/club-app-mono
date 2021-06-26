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
  final WsClient wsClient;

  const MainPageGroupless({required this.wsClient});
}

class MainPageWithGroup extends MainPageState {
  final WsClient wsClient;
  final Group group;

  const MainPageWithGroup({required this.wsClient, required this.group});
}
