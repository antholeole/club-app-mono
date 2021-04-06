import 'package:fe/data_classes/chat_message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

class Chat {
  final UuidType id;
  final String name;
  final List<Message> chats;

  Chat({required this.id, required this.name, required this.chats});
}
