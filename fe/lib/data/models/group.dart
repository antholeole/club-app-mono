import '../../stdlib/helpers/uuid_type.dart';

class Group {
  final UuidType _id;
  String name;
  bool admin;
  bool hasNotifications = false;

  UuidType get id => _id;

  Group({required UuidType id, required this.name, required this.admin})
      : _id = id;
}
