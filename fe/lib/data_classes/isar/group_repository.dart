import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';
import 'package:fe/isar.g.dart';

import '../../service_locator.dart';
import 'group.dart';

class GroupRepository {
  final _isar = getIt<Isar>();

  GroupRepository();

  Future<List<Group>> findAll() async {
    return _isar.groups.where().findAll();
  }

  Future<void> addOne(Group group) async {
    await _isar.writeTxn((isar) async {
      await isar.groups.put(group);
    });
  }

  Future<bool> removeById(UuidType id) async {
    return await _isar.writeTxn((isar) async {
      return await isar.groups.where().filter().idEqualTo(id).deleteFirst();
    });
  }
}
