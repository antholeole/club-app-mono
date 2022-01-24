import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:time_range/time_range.dart';

class EventTimeField extends FormField<TimeRangeResult> {
  EventTimeField(
      {required BuildContext context,
      required GlobalKey<FormFieldState<bool>> allDayToggleKey})
      : super(
          onSaved: (value) {
            final cubit = context.read<EventCreatorFormCubit>();

            cubit.update(cubit.state.copyWith(eventTime: value));
          },
          validator: (value) {
            if (allDayToggleKey.currentState!.value! == false &&
                value == null) {
              return 'You must either select a time range or set the event as all day.';
            }
          },
          builder: (field) => allDayToggleKey.currentState!.value!
              ? Container()
              : Column(
                  children: [
                    TimeRange(
                      borderColor: Colors.grey,
                      fromTitle: Text('From',
                          style: Theme.of(context).textTheme.subtitle2),
                      toTitle: Text('To',
                          style: Theme.of(context).textTheme.subtitle2),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black87),
                      activeTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      backgroundColor: Colors.transparent,
                      firstTime: const TimeOfDay(hour: 0, minute: 0),
                      lastTime: const TimeOfDay(hour: 24, minute: 00),
                      timeStep: 10,
                      timeBlock: 30,
                      onRangeCompleted: field.didChange,
                    ),
                    if (field.hasError)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          field.errorText!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      )
                  ],
                ),
        );
}
