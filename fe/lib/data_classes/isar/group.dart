import 'package:fe/data_classes/isar/base_model.dart';
import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';

@Collection()
class Group extends BaseModel {
  @override
  @Id()
  int? isar_id;

  @override
  @Index(unique: true, indexType: IndexType.hash)
  @IsarUuidConverter()
  late UuidType id;

  late String name;

  @Backlink(to: 'groups')
  IsarLinks<User> users = IsarLinks<User>();

  @override
  void overrideNonessentals(Group other) {
    name = other.name;
  }
}
