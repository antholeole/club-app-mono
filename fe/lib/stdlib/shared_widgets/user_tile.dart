import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';

import 'package:flutter/material.dart';
import 'package:fe/gql/get_or_create_dm.req.gql.dart';
import 'package:provider/src/provider.dart';

import '../../service_locator.dart';

class UserTile extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();

  final User _user;
  final bool _showDmButton;
  final Widget? _subtitle;

  UserTile({
    required User user,
    Key? key,
    Widget? subtitle,
    bool showDmButton = true,
  })  : _user = user,
        _subtitle = subtitle,
        _showDmButton = showDmButton,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            _user.name,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: Avatar.user(
            user: _user,
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            if (_showDmButton)
              _buildActionButton(() => _createNewDm(_user.id, context),
                  Icons.chat_outlined, context)
          ]),
        ),
        if (_subtitle != null) _subtitle!
      ],
    );
  }

  Future<void> _createNewDm(UuidType withUser, BuildContext context) async {
    try {
      final thread = await _gqlClient
          .request(GGetOrCreateDmReq((q) => q..vars.withUserId = withUser))
          .first;

      context
          .read<HydratedSetter<Group>>()
          .set(Dm(id: thread.get_or_create_dm!.id, users: [_user]));

      Navigator.of(context).pop();
    } on Failure catch (f) {
      getIt<Handler>().handleFailure(f, context);
    }
  }

  Widget _buildActionButton(
      VoidCallback onClick, IconData icon, BuildContext context) {
    return GestureDetector(
        onTap: onClick, child: Icon(icon, color: Colors.grey.shade500));
  }
}
