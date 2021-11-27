part of 'page_cubit.dart';

class PageState extends Union2Impl<EventsPageState, ChatPageState> {
  static const unions = Doublet<EventsPageState, ChatPageState>();

  PageState._(Union2<EventsPageState, ChatPageState> union) : super(union);

  factory PageState.chatPage({Thread? toThread}) =>
      PageState._(unions.second(ChatPageState(thread: toThread)));

  factory PageState.eventPage() =>
      PageState._(unions.first(const EventsPageState()));

  int get index => join((_) => 1, (_) => 0);
}

class EventsPageState extends Equatable {
  const EventsPageState();

  @override
  List<Object?> get props => [];
}

class ChatPageState extends Equatable {
  final Thread? thread;

  const ChatPageState({this.thread});

  @override
  List<Object?> get props => [thread];
}
