import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ical/serializer.dart';
import 'package:provider/src/provider.dart';
import 'package:ical/src/abstract.dart';

class EventRepeats extends FormField<List<bool>> {
  static const DAYS_TEXT = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'];

  EventRepeats(
      {required BuildContext context,
      required GlobalKey<FormFieldState<DateTime>> until,
      required GlobalKey<FormFieldState<List<bool>>> key})
      : super(
            key: key,
            onSaved: (events) {
              final cubit = context.read<EventCreatorFormCubit>();

              cubit.update(cubit.state.copyWith(
                  reoccurOn: events!,
                  recurrenceRule: IRecurrenceRule(
                      frequency: IRecurrenceFrequency.WEEKLY,
                      untilDate: until.currentState!.value)));
            },
            initialValue: EventRepeats.DAYS_TEXT.map((e) => false).toList(),
            builder: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Repeats every...',
                        style: Theme.of(context).textTheme.subtitle2),
                    LayoutBuilder(
                      builder: (_, constraints) => ToggleButtons(
                        selectedColor: Colors.white,
                        fillColor: Theme.of(context).colorScheme.primary,
                        onPressed: (index) => state.didChange(
                            List.from(state.value!)
                              ..[index] = !state.value![index]),
                        constraints: BoxConstraints.expand(
                            width: (constraints.maxWidth - 8) /
                                EventRepeats.DAYS_TEXT.length),
                        isSelected: state.value!,
                        children: EventRepeats.DAYS_TEXT
                            .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: (Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .fontSize ??
                                              12) -
                                          0.5),
                                )))
                            .toList(),
                      ),
                    ),
                  ],
                ));
}
