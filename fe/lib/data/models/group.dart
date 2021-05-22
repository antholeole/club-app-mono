import '../../stdlib/helpers/uuid_type.dart';

class Group {
  final UuidType id;
  final String name;
  final bool admin;

  const Group({required this.id, required this.name, required this.admin});
}
