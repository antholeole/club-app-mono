import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';

@Collection()
class Group {
  @Id()
  int? isar_id;

  @Index(unique: true, indexType: IndexType.hash)
  @IsarUuidConverter()
  late UuidType id;
  late String name;
}
