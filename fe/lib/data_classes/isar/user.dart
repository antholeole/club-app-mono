import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';

@Collection()
class User {
  @Id()
  int? isar_id;

  @Index(unique: true, indexType: IndexType.hash)
  @IsarUuidConverter()
  late UuidType id;

  late String name;
  late String? profilePicture;
  bool hasDm = false;

  IsarLinks<Group> groups = IsarLinks<Group>();

  @override
  bool operator ==(covariant User other) => id == other.id;
}
