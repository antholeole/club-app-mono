import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

class Message {
  final User sender;
  final String message;
  final DateTime sentAt;
  final bool edited;
  final UuidType id;

  const Message(
      {required this.sender,
      required this.id,
      required this.message,
      required this.sentAt,
      required this.edited});
}
