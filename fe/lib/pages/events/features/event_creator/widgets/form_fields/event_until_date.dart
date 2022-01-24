import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventUntilDate extends FormField<DateTime> {
  static bool anyRepeats(GlobalKey<FormFieldState<List<bool>>> repeats) {
    return repeats.currentState!.value!.any((element) => element);
  }

  EventUntilDate({
    required BuildContext context,
    required GlobalKey<FormFieldState<DateTime>> key,
    required GlobalKey<FormFieldState<DateTime>> startDate,
    required GlobalKey<FormFieldState<List<bool>>> repeats,
  }) : super(
            key: key,
            initialValue: DateTime.now(),
            validator: (value) {
              if (value == null && anyRepeats(repeats)) {
                return 'Must select ending date';
              }

              if (value == null) {
                return null;
              }

              if (startDate.currentState!.value!.microsecondsSinceEpoch >
                  value.microsecondsSinceEpoch) {
                return 'Ending date must be after starting date';
              }
            },
            builder: (state) {
              if (!anyRepeats(repeats)) {
                return Container();
              }

              return Column(
                children: [
                  GestureDetector(
                      onTap: () => showDatePicker(
                                  context: context,
                                  initialDate: state.value!,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101))
                              .then((newValue) {
                            if (newValue != null) {
                              state.didChange(newValue);
                            }
                          }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Row(
                              children: [
                                Text(DateFormat.yMMMMd('en_US')
                                    .format(state.value!)),
                                const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    )
                ],
              );
            });
}
