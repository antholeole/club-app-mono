import 'package:fe/stdlib/helpers/uuid_type.dart';

abstract class BaseModel {
  int? isar_id;

  late UuidType id;

  @override
  bool operator ==(covariant BaseModel other) => id == other.id;

  //overrides nonessential self properties to be equal to another.
  //This is done for easy remote syncing.
  void overrideNonessentals(covariant BaseModel other);
}
