import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:web_socket_channel/io.dart';

import '../../../service_locator.dart';

class WsClient {
  final TokenManager _tokenManager = getIt<TokenManager>();
  late IOWebSocketChannel _wsChannel;

  WsClient(String initalAToken) {
    _wsChannel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'),
        headers: {'Authorization': 'Bearer $initalAToken'});
  }

  Future<void> send(WsMessage message) async {
    _wsChannel.sink.add(message.toJson());
  }
}
