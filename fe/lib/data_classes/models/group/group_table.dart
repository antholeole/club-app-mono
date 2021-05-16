import 'package:fe/data_classes/models/base/base_table.dart';
import 'package:moor/moor.dart';

class Groups extends BaseTable {
  TextColumn get name => text()();
  TextColumn get joinToken => text().nullable()();
  BoolColumn get isAdmin => boolean().withDefault(const Constant(false))();
}
