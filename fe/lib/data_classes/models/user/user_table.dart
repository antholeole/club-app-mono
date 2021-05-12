import 'package:fe/data_classes/models/base/base_table.dart';
import 'package:moor/moor.dart';

class Users extends BaseTable {
  TextColumn get profilePicture => text().nullable()();
  TextColumn get name => text()();
  BoolColumn get hasDm => boolean().withDefault(const Constant(false))();
}
