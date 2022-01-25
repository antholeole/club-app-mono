import 'dart:convert';

import 'package:collection/src/iterable_extensions.dart';
import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_state.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ical/serializer.dart';

class EventCreatorFormCubit extends Cubit<EventCreatorFormState> {
  EventCreatorFormCubit() : super(EventCreatorFormState());

  void update(EventCreatorFormState newState) {
    emit(newState);
  }

  String get() {
    final event = IEvent(start: DateTime.now(), rrule: state.recurrenceRule);
    if (state.allDay!) {
      event.start =
          DateTime(state.day!.year, state.day!.month, state.day!.day, 0, 0);
      event.end =
          DateTime(state.day!.year, state.day!.month, state.day!.day + 1, 0, 0);
    } else {
      event.start = DateTime(state.day!.year, state.day!.month, state.day!.day,
          state.eventTime!.start.hour, state.eventTime!.start.minute);
      event.end = DateTime(state.day!.year, state.day!.month, state.day!.day,
          state.eventTime!.end.hour, state.eventTime!.end.minute);
    }

    event.description = state.description;
    event.uid = UuidType.generate().uuid;

    return _addByday(event.serialize(), state.reoccurOn!);
  }

  //hack for now; ical package does not support byday, but we need it.
  String _addByday(String event, List<bool> reoccurOn) {
    final reoccur =
        IRecurrenceRule.weekdays.whereIndexed((i, e) => reoccurOn[i]).join(',');

    return const LineSplitter().convert(event).map((e) {
      if (e.startsWith('RRULE')) {
        return '$e;BYDAY=$reoccur';
      }

      return e;
    }).join('\n');
  }
}
