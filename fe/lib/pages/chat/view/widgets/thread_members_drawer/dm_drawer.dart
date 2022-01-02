import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/users_list.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:flutter/material.dart';
import 'package:fe/gql/query_users_in_dm.data.gql.dart';
import 'package:fe/gql/query_users_in_dm.var.gql.dart';
import 'package:fe/gql/query_users_in_dm.req.gql.dart';
import 'package:provider/src/provider.dart';

class DmDrawer extends StatelessWidget {
  const DmDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GqlOperation<GQueryUsersInDmData, GQueryUsersInDmVars>(
        operationRequest: GQueryUsersInDmReq(
            (req) => req..vars.dmId = context.read<Thread>().id),
        onResponse: (data) => UsersList(
              users: data.user_to_dm.map((user) => User(
                    id: user.user.id,
                    name: user.user.name,
                  )),
            ));
  }
}
