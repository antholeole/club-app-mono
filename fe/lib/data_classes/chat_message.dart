import 'package:fe/data_classes/user.dart';

enum MessageType { Chat, Image }

abstract class Message {
  User from;
  MessageType messageType;

  Message({required this.from, required this.messageType});
}

class ImageMessage extends Message {
  Uri message;

  ImageMessage(
      {required User from,
      required MessageType messageType,
      required this.message})
      : super(from: from, messageType: messageType);
}

class ChatMessage extends Message {
  String message;

  ChatMessage(
      {required User from,
      required MessageType messageType,
      required this.message})
      : super(from: from, messageType: messageType);
}
