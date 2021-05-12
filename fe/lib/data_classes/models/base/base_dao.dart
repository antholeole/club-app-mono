import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:moor/moor.dart';

abstract class BaseDao<T extends DataClass>
    extends DatabaseAccessor<DatabaseManager> {
  // this constructor is required so that the main database can create an instance
  // of this object.
  BaseDao(DatabaseManager db) : super(db);
  Future<void> removeOne(UuidType id);
  Future<T?> findOne(UuidType id);
  Future<void> addOne(T entry);
  Future<void> overrideLocal(T other);
}
