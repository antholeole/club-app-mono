import 'package:fe/data/models/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ical/serializer.dart';
import 'package:time_range/time_range.dart';

part 'event_creator_form_state.freezed.dart';

@freezed
class EventCreatorFormState with _$EventCreatorFormState {
  factory EventCreatorFormState({
    DateTime? day,
    String? description,
    String? eventName,
    bool? allDay,
    @Default([]) List<Role> roles,
    List<bool>? reoccurOn,
    IRecurrenceRule? recurrenceRule,
    TimeRangeResult? eventTime,
  }) = _EventCreatorFormState;
}
