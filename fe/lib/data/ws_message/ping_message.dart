import 'package:fe/data/ws_message/ws_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ping_message.g.dart';

@JsonSerializable()
class WsPingMessage extends WsMessage {
  @override
  WsMessageType get messageType => WsMessageType.Ping;

  const WsPingMessage();

  factory WsPingMessage.fromJson(Map<String, dynamic> json) =>
      _$WsPingMessageFromJson(json);

  @override
  Map<String, dynamic> selfToJson() => _$WsPingMessageToJson(this);

  @override
  List<Object?> get props => [messageType];
}
