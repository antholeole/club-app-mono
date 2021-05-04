import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';

class UserRepository {
  final _isar = getIt<Isar>();

  Future<List<User>> findUserInGroup(UuidType groupId) async {
    return _isar.users
        .where()
        .filter()
        .group((g) => g.idEqualTo(groupId))
        .findAll();
  }
}
