import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

class BaseTable extends Table {
  TextColumn get id =>
      text().map(const MoorUuidConverter()).clientDefault(() => Uuid().v4())();

  @override
  Set<Column> get primaryKey => {id};
}
