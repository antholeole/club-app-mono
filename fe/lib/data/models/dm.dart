import 'package:equatable/equatable.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

class Dm extends Group implements Equatable {
  final List<User> users;

  Dm({required UuidType id, required this.users, String? name})
      : super(id: id, name: name ?? _defaultName(users));

  static String _defaultName(List<User> users) =>
      users.map((user) => user.name).join(', ');

  @override
  List<Object?> get props => [id, name];
}
