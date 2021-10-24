import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';

import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/random_string.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/upsert_group_join_token.data.gql.dart';
import 'package:fe/gql/upsert_group_join_token.var.gql.dart';
import 'package:fe/gql/upsert_group_join_token.req.gql.dart';
import 'package:provider/src/provider.dart';

import '../../../../../../service_locator.dart';

class JoinTokenTile extends StatelessWidget {
  final _gqlClient = getIt<AuthGqlClient>();
  final _handler = getIt<Handler>();

  @visibleForTesting
  static const String NO_JOIN_TOKEN_TEXT = 'No Join Token.';

  JoinTokenTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.read<Club>();

    return Column(
      children: [
        Tile(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(group.joinToken ?? NO_JOIN_TOKEN_TEXT),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _updateToken(context,
                          clubId: group.id, delete: false),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.blue.shade300,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          _updateToken(context, clubId: group.id, delete: true),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red.shade300,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _updateToken(BuildContext context,
      {required UuidType clubId, required bool delete}) async {
    try {
      await _gqlClient
          .request<GUpsertGroupJoinTokenData, GUpsertGroupJoinTokenVars>(
              GUpsertGroupJoinTokenReq((q) => q
                ..vars.group_id = clubId
                ..vars.new_token = delete ? null : generateRandomString(10)))
          .first;
      context.read<GroupReqCubit>().refresh();
    } on Failure catch (f) {
      _handler.handleFailure(f, context);
    }
  }
}
