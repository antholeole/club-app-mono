import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class EventDate extends FormField<DateTime> {
  EventDate(
      {required BuildContext context,
      required GlobalKey<FormFieldState<DateTime>> key})
      : super(
            key: key,
            initialValue: DateTime.now(),
            onSaved: (newValue) {
              final cubit = context.read<EventCreatorFormCubit>();

              cubit.update(cubit.state.copyWith(day: newValue));
            },
            validator: (value) {
              if (value == null) {
                return 'Must select starting date';
              }

              if (value.day < DateTime.now().day) {
                return 'Starting date must be today or in the future';
              }
            },
            builder: (state) => Column(
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
                                'Date',
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
                        style: TextStyle(color: Colors.red.shade700),
                      )
                  ],
                ));
}
