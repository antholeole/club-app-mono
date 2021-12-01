import 'package:fe/data/models/role.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../users.dart';

class AddableRoleDropdown extends StatelessWidget {
  final void Function(Iterable<Role>) _addRoles;

  const AddableRoleDropdown(
      {Key? key, required void Function(Iterable<Role>) addRoles})
      : _addRoles = addRoles,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final addableRoles = context.watch<UserRoles>().addableRoles!;

    if (addableRoles.isEmpty) {
      return const Tooltip(
          message: 'All roles applied.',
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.check,
            color: Colors.grey,
          ));
    }

    return StatefulBuilder(builder: (context, setStateful) {
      final Map<UuidType, Role> roles = {};

      return PopupMenuButton<Iterable<Role>>(
        onCanceled: () {
          _addRoles(roles.values);
          roles.clear();
        },
        itemBuilder: (_) => addableRoles
            .map((e) => PopupMenuItem<List<Role>>(
                  onTap: () {},
                  padding: EdgeInsets.zero,
                  value: [],
                  child: StatefulBuilder(
                    builder: (_context, _setState) => CheckboxListTile(
                      value: roles.containsKey(e.id),
                      onChanged: (value) => _setState(() =>
                          roles.containsKey(e.id)
                              ? roles.remove(e.id)
                              : roles[e.id] = e),
                      title: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ))
            .toList(),
        icon: const Icon(Icons.add, color: Colors.grey),
      );
    });
  }
}
