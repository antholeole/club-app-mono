import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'group.dart';

class UserRepository {
  final _isar = getIt<Isar>();
  final _gqlClient = getIt<Client>();
  final _user = getIt<LocalUser>();

  Future<List<User>> findUserInGroup(UuidType groupId) async {
    return _isar.users
        .where()
        .filter()
        .group((g) => g.idEqualTo(groupId))
        .findAll();
  }
}
