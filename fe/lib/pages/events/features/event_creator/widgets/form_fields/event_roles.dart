import 'package:fe/data/models/role.dart';
import 'package:fe/pages/events/features/event_creator/cubit/event_creator_form_cubit.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/role_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class EventRoles extends FormField<List<Role>> {
  EventRoles({
    required BuildContext context,
    required List<Role> allRoles,
    required GlobalKey<FormFieldState<List<Role>>> key,
  }) : super(
            key: key,
            onSaved: (state) {
              final cubit = context.read<EventCreatorFormCubit>();
              cubit.update(cubit.state.copyWith(roles: state!));
            },
            validator: (state) {
              if (state!.isEmpty) {
                return 'You must select atleast one role that can see this event.';
              }
            },
            initialValue: [],
            builder: (state) {
              final hasRoles = state.value!;
              final needsRoles =
                  allRoles.where((role) => !hasRoles.contains(role)).toList();

              return Column(
                children: [
                  RoleManager(
                    initallyOpen: true,
                    roleManagerData: RoleManagerData(
                        initalAddableRoles: needsRoles,
                        removeRole: (removed) => state.didChange(
                            List.from(state.value!)..remove(removed)),
                        addRoles: (added) => state
                            .didChange(List.from([...state.value!, ...added]))),
                    initalRoles: hasRoles,
                    header: Text('Roles (That can see this event)',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: Colors.black)),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.errorText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    )
                ],
              );
            });
}
