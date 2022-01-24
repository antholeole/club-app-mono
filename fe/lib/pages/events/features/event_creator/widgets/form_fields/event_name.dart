import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class EventName extends StatelessWidget {
  const EventName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => context.read<EventCreatorFormCubit>().update(context
          .read<EventCreatorFormCubit>()
          .state
          .copyWith(eventName: value)),
      decoration: const InputDecoration(labelText: 'Event Name'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
