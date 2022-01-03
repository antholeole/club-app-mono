import 'package:flutter/material.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/gql/query_users_in_thread.data.gql.dart';
import 'package:fe/gql/query_users_in_thread.var.gql.dart';
import 'package:fe/gql/query_users_in_thread.req.gql.dart';
import 'package:provider/src/provider.dart';

import '../users_list.dart';

class ThreadUsers extends StatelessWidget {
  const ThreadUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GqlOperation<GQueryUsersInThreadData, GQueryUsersInThreadVars>(
        operationRequest: GQueryUsersInThreadReq(
            (req) => req..vars.threadId = context.read<Thread>().id),
        onResponse: (data) => UsersList(
              users: data.user_to_thread.map((user) => User(
                    name: user.user!.name,
                    id: user.user!.id,
                  )),
            ));
  }
}
