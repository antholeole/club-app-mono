import 'package:fe/data/models/user.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/shared_widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UsersList extends StatelessWidget {
  final Iterable<User> _users;

  @visibleForTesting
  static const NO_USERS_COPY =
      'There are no users in this thread; add a role and all the users in that role will be added.';

  const UsersList({
    Key? key,
    required Iterable<User> users,
  })  : _users = users,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Users',
      ),
      children: _users.isEmpty
          ? [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  NO_USERS_COPY,
                  textAlign: TextAlign.center,
                ),
              )
            ]
          : _users
              .map((user) => UserTile(
                    user: user,
                    showDmButton: user.id != context.read<UserCubit>().user.id,
                  ))
              .toList(),
    );
  }
}
