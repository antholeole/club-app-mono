import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => context.read<EventCreatorFormCubit>().update(context
          .read<EventCreatorFormCubit>()
          .state
          .copyWith(description: value)),
      keyboardType: TextInputType.multiline,
      minLines: 4,
      maxLines: 4,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Event Description'),
    );
  }
}
