import 'package:fe/data_classes/isar/base_model.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'isar_exceptions.dart';

abstract class BaseRepository<T extends BaseModel> {
  //if remote is set to true, then data is fetched from the server as well
  Future<void> removeOne(UuidType id);
  Future<T?> findOne(UuidType id);
  Future<void> addOne(T t);

  //uses other to override all non-essential (non-id) props of current.
  Future<void> updateLocal(T other);

  @protected
  Future<void> putLocal(T other, IsarCollection<T> db, Isar isar) async {
    final group = await findOne(other.id);

    if (group == null) {
      throw OverrideNonexistantError();
    }

    await isar.writeTxn((isar) async {
      group.overrideNonessentals(other);

      await db.put(group);
    });
  }
}
