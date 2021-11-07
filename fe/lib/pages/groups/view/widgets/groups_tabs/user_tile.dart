import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/user_avatar.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fe/gql/get_or_create_dm.req.gql.dart';
import 'package:provider/src/provider.dart';

import '../../../../../service_locator.dart';

class UserTile extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();

  final User _user;

  UserTile({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: UserAvatar(
              name: _user.name,
              profileUrl: _user.profilePictureUrl,
            ),
          ),
          Expanded(child: Text(_user.name)),
          GestureDetector(
              onTap: () => _createNewDm(_user.id, context),
              child: Icon(Icons.chat_outlined, color: Colors.grey.shade500))
        ]),
      ),
    );
  }

  Future<void> _createNewDm(UuidType withUser, BuildContext context) async {
    try {
      final thread = await _gqlClient
          .request(GGetOrCreateDmReq((q) => q..vars.withUserId = withUser))
          .first;

      context
          .read<MainCubit>()
          .setDm(Dm(id: thread.get_or_create_dm!.id, users: [_user]));

      Navigator.of(context).pop();
    } on Failure catch (f) {
      getIt<Handler>().handleFailure(f, context);
    }
  }
}
