import 'package:fe/data/models/role.dart';
import 'package:fe/stdlib/shared_widgets/checkbox_dropdown.dart';
import 'package:flutter/material.dart';

class AddableRoleDropdown extends StatelessWidget {
  final void Function(Iterable<Role>) _addRoles;
  final List<Role> _addableRoles;

  const AddableRoleDropdown(
      {Key? key,
      required void Function(Iterable<Role>) addRoles,
      required List<Role> addableRoles})
      : _addRoles = addRoles,
        _addableRoles = addableRoles,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_addableRoles.isEmpty) {
      return const Tooltip(
          message: 'All roles applied.',
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.check,
            color: Colors.grey,
          ));
    }

    return CheckboxDropdown<Role>(
        checkableItems: _addableRoles,
        elementRepr: (role) => role.name,
        onSubmitted: _addRoles);
  }
}
