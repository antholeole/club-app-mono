import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

abstract class Group extends Equatable {
  final String name;
  final UuidType id;

  const Group({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];
}
