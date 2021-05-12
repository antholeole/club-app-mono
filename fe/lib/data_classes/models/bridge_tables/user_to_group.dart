import 'package:fe/data_classes/models/base/base_table.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

class UserToGroup extends BaseTable {
  TextColumn get userId => text()
      .map(const MoorUuidConverter())
      .clientDefault(() => Uuid().v4())
      .customConstraint('REFERENCES users(id)')();

  TextColumn get groupId => text()
      .map(const MoorUuidConverter())
      .clientDefault(() => Uuid().v4())
      .customConstraint('REFERENCES groups(id)')();
}
