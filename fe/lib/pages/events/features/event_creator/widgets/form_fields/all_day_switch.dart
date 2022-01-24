import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/src/provider.dart';

class AllDaySwitch extends FormField<bool> {
  AllDaySwitch(
      {required BuildContext context,
      required GlobalKey<FormFieldState<bool>> key})
      : super(
            key: key,
            initialValue: false,
            onSaved: (value) => context.read<EventCreatorFormCubit>().update(
                context
                    .read<EventCreatorFormCubit>()
                    .state
                    .copyWith(allDay: value)),
            builder: (state) => Row(
                  children: [
                    Text('All Day',
                        style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 15),
                    PlatformSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: state.value!,
                      onChanged: state.didChange,
                    ),
                  ],
                ));
}
