import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/user_tile.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class Users extends StatelessWidget {
  @visibleForTesting
  static const String ERROR_LOADING_USERS = 'Error loading members';

  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return Column(
      children: [
        const TileHeader(text: 'Members'),
        GqlOperation(
            operationRequest: GQueryUsersInGroupReq(
              (b) => b
                ..fetchPolicy = FetchPolicy.CacheAndNetwork
                ..vars.groupId = group.id,
            ),
            errorText: ERROR_LOADING_USERS,
            onResponse: (GQueryUsersInGroupData data) => Column(
                children: data.user_to_group
                    .map((user) => UserTile(
                            user: User(
                          id: user.user.id,
                          name: user.user.name,
                          profilePictureUrl: user.user.profile_picture,
                        )))
                    .toList())),
      ],
    );
  }
}
