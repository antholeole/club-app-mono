import 'package:fe/data_classes/isar/user.dart';
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

  @Backlink(to: 'groups')
  IsarLinks<User> users = IsarLinks<User>();

  @override
  bool operator ==(covariant Group other) => id == other.id;
}
