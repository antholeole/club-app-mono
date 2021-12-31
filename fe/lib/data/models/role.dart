import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';

@freezed
class Role with _$Role {
  factory Role({required UuidType id, required String name}) = _Role;
}
