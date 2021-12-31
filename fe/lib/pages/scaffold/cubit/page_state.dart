import 'package:fe/data/models/thread.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_state.freezed.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState.events() = _Events;
  const factory PageState.chat([Thread? thread]) = _Chat;

  int get index => map(events: (_) => 1, chat: (_) => 0);
}
