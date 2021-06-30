import 'dart:convert';

import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/helpers/DEBUG_print.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:web_socket_channel/io.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

class WsClient {
  final TokenManager _tokenManager = getIt<TokenManager>();
  final Config _config = getIt<Config>();
  late IOWebSocketChannel _wsChannel;

  WsClient(String initalAToken) {
    _wsChannel = IOWebSocketChannel.connect(Uri.parse(_config.wsUrl),
        headers: {'Authorization': 'Bearer $initalAToken'});

    _wsChannel.stream.listen((event) {
      printWrapped(event);
    });
  }

  Future<void> send(WsMessage message) async {
    _wsChannel.sink.add(json.encode(message.toJson()));
  }
}
