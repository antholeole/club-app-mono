import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sublclasses should have type in toJson', () {
    final t = WsMessageMessage(
        message: 'hi', toId: UuidType('0f94bbfc-d9b2-4744-b7b8-169b17fb5c0d'));

    final dict = t.toJson();

    expect(dict['type'], 'Message');
    expect(dict['message'], 'hi');
  });
}
