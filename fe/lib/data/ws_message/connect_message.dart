import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connect_message.g.dart';

@JsonSerializable()
@CustomUuidConverter()
class WsConnectMessage extends WsMessage {
  @override
  WsMessageType get messageType => WsMessageType.Message;

  const WsConnectMessage();

  factory WsConnectMessage.fromJson(Map<String, dynamic> json) =>
      _$WsConnectMessageFromJson(json);

  @override
  Map<String, dynamic> selfToJson() => _$WsConnectMessageToJson(this);
}
