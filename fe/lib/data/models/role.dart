import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

class Role extends Equatable {
  final UuidType id;
  final String name;

  const Role({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
