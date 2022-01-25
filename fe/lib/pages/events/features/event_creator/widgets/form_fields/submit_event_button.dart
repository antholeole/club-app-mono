import 'package:built_collection/built_collection.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/role.dart';
import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/insert_new_event.req.gql.dart';
import 'package:fe/schema.schema.gql.dart' show Groles_to_events_insert_input;

class SubmitEventButton extends StatelessWidget {
  final AuthGqlClient _authGqlClient = getIt<AuthGqlClient>();
  final GlobalKey<FormState> _formKey;
  final GlobalKey<FormFieldState<List<Role>>> _rolesKey;

  SubmitEventButton(
      {Key? key,
      required GlobalKey<FormState> formKey,
      required GlobalKey<FormFieldState<List<Role>>> rolesKey})
      : _formKey = formKey,
        _rolesKey = rolesKey,
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

            _authGqlClient.mutateFromUi(
                GInsertEventReq((q) => q
                  ..vars.eventId = UuidType.generate()
                  ..vars.groupId = context.read<Club>().id
                  ..vars.iCalEvent = context.read<EventCreatorFormCubit>().get()
                  ..vars.roles = ListBuilder(_rolesKey.currentState!.value!.map(
                      (e) => Groles_to_events_insert_input(
                          (i) => i..role_id = e.id)))),
                context,
                onComplete: (_) => Navigator.of(context).pop(),
                errorMessage: 'Failed to submit event',
                successMessage: 'created event!');
          } else {
            context.read<ToasterCubit>().add(Toast(
                message: 'invalid event; please correct the indicated fields.',
                type: ToastType.Error));
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
