import 'package:fe/data_classes/isar/base_model.dart';
import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:isar/isar.dart';

@Collection()
class User extends BaseModel {
  @Id()
  @override
  int? isar_id;

  @override
  @Index(unique: true, indexType: IndexType.hash)
  @IsarUuidConverter()
  late UuidType id;

  late String name;
  late String? profilePicture;
  bool hasDm = false;

  IsarLinks<Group> groups = IsarLinks<Group>();

  @override
  bool operator ==(covariant User other) => id == other.id;

  @override
  void overrideNonessentals(User other) {
    profilePicture = other.profilePicture;
  }
}
