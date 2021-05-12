import 'package:fe/data_classes/models/base/base_table.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

class Groups extends BaseTable {
  TextColumn get name => text()();

  @override
  TextColumn get id =>
      text().map(const MoorUuidConverter()).clientDefault(() => Uuid().v4())();
}
