import 'package:isar/isar.dart';

@Collection()
class Contact {
  @Id()
  int? isar_id;

  String firstName;

  String lastName;

  bool isStarred;
}
