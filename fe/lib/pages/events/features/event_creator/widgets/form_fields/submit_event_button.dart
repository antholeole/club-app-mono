import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SubmitEventButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;

  const SubmitEventButton({Key? key, required GlobalKey<FormState> formKey})
      : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.primaryVariant,
            backgroundColor: Theme.of(context).colorScheme.primary),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<EventCreatorFormCubit>().get();
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Create Event',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
