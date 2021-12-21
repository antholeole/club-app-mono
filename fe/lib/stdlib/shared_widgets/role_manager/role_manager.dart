import 'package:fe/data/models/role.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/addable_roles_dropdown.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/shared_widgets/toasting_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../service_locator.dart';

class RoleManagerData {
  final List<Role> initalAddableRoles;

  final String Function(List<Role>) successfullyAddedRolesText;
  final String Function() failedToAddRolesText;
  final Future<void> Function(List<Role>) addRoles;

  final String Function(Role) removeRolePromptText;
  final Future<void> Function(Role) removeRole;
  final String Function(Role) successfullyRemovedRoleText;
  final String Function(Role) failedToRemoveRoleText;

  const RoleManagerData(
      {required this.initalAddableRoles,
      required this.removeRolePromptText,
      required this.successfullyRemovedRoleText,
      required this.removeRole,
      required this.failedToRemoveRoleText,
      required this.failedToAddRolesText,
      required this.addRoles,
      required this.successfullyAddedRolesText});
}

/// make initalAddableRoles null if not addable.
class RoleManager extends StatefulWidget {
  static const CONFIRM_REMOVE_TEXT = 'Remove';

  final Widget _header;
  final List<Role> _hasRoles;
  final RoleManagerData? _roleManagerData;

  const RoleManager(
      {Key? key,
      required List<Role> initalRoles,
      required Widget header,
      RoleManagerData? roleManagerData})
      : _hasRoles = initalRoles,
        _header = header,
        _roleManagerData = roleManagerData,
        super(key: key);

  @override
  _RoleManagerState createState() => _RoleManagerState();
}

class _RoleManagerState extends State<RoleManager> {
  final _handler = getIt<Handler>();

  late List<Role> _displayingHasRoles;
  List<Role>? _displayingAddableRoles;

  @override
  void initState() {
    _displayingHasRoles = List.from(widget._hasRoles);

    if (widget._roleManagerData != null) {
      _displayingAddableRoles =
          List.from(widget._roleManagerData!.initalAddableRoles);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    child: widget._header,
                  ),
                  if (_displayingAddableRoles != null)
                    AddableRoleDropdown(
                      addableRoles: _displayingAddableRoles!,
                      addRoles: (roles) => _addRoles(roles.toList(), context),
                    )
                ],
              ),
              children: _displayingHasRoles
                  .map((role) =>
                      _buildRoleTile(role, _displayingHasRoles, context))
                  .toList(),
            )));
  }

  Widget _buildRoleTile(
      Role role, List<Role>? addableRoles, BuildContext context) {
    final tile = ListTile(
      title: Text(
        role.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );

    if (widget._roleManagerData != null) {
      return ToastingDismissable(
          key: Key(role.id.uuid),
          confirmDismissText:
              widget._roleManagerData!.removeRolePromptText(role),
          onConfirm: () => _removeRole(role, context),
          actionText: RoleManager.CONFIRM_REMOVE_TEXT,
          child: tile);
    }

    return tile;
  }

  Future<void> _addRoles(List<Role> roles, BuildContext context) async {
    if (roles.isEmpty) {
      return;
    }

    try {
      await widget._roleManagerData!.addRoles(roles);

      context.read<ToasterCubit>().add(Toast(
          message: widget._roleManagerData!.successfullyAddedRolesText(roles),
          type: ToastType.Success));

      //diff the two lists
      final List<Role> newAddableRoles = [];
      for (final role in _displayingAddableRoles!) {
        if (!roles.contains(role)) {
          newAddableRoles.add(role);
        }
      }

      setState(() {
        _displayingHasRoles = List.from([..._displayingHasRoles, ...roles]);
        _displayingAddableRoles = newAddableRoles;
      });
    } on Failure catch (f) {
      _handler.handleFailure(f, context,
          withPrefix: widget._roleManagerData!.failedToAddRolesText());
    }
  }

  Future<void> _removeRole(Role role, BuildContext context) async {
    try {
      await widget._roleManagerData!.removeRole(role);

      context.read<ToasterCubit>().add(Toast(
          message: widget._roleManagerData!.successfullyRemovedRoleText(role),
          type: ToastType.Success));

      setState(() {
        _displayingHasRoles = List.from(_displayingHasRoles..remove(role));
        _displayingAddableRoles =
            List.from([..._displayingAddableRoles!, role]);
      });
    } on Failure catch (f) {
      _handler.handleFailure(f, context,
          withPrefix: widget._roleManagerData!.failedToRemoveRoleText(role));
    }
  }
}
