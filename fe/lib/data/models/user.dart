import 'package:fe/stdlib/helpers/uuid_type.dart';

class User {
  final String name;
  final String? profilePictureUrl;
  final UuidType id;

  const User({required this.name, this.profilePictureUrl, required this.id});
}
