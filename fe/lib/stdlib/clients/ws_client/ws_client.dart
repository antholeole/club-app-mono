import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/data/ws_message/ping_message.dart';
import 'package:fe/stdlib/clients/http_client/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

enum WsConnectionState { Connecting, Connected, Error }

class WsClient {
  final TokenManager _tokenManager = getIt<TokenManager>();
  final UnauthHttpClient _unauthHttpClient = getIt<UnauthHttpClient>();
  final Config _config = getIt<Config>();

  final StreamController<Failure> _failureStream = StreamController();
  final StreamController<WsMessage> _messageStream = StreamController();
  final StreamController<WsConnectionState> _connectionStateController =
      StreamController();

  IOWebSocketChannel? _wsChannel;

  WsClient();

  Stream<WsConnectionState> connectionState() {
    return _connectionStateController.stream;
  }

  Stream<Failure> errorStream() {
    return _failureStream.stream;
  }

  Stream<WsMessage> messageStream() {
    return _messageStream.stream;
  }

  Future<void> initalize() async {
    _connectionStateController.add(WsConnectionState.Connecting);

    _wsChannel = IOWebSocketChannel.connect(Uri.parse(_config.wsUrl),
        headers: {'Authorization': 'Bearer ${await _tokenManager.read()}'});

    _wsChannel!.stream
        .listen(_onMessage, onError: _handleWsException, onDone: _onDone);
    print('hi');

    _wsChannel!.stream.timeout(const Duration(seconds: 10));
  }

  void _onMessage(dynamic message) {
    print('got something');
    final jsonMessage = json.decode(message);
    final wsMessageType = WsMessage.determineMessage(message);

    switch (wsMessageType) {
      case WsMessageType.Ping:
      case WsMessageType.Connect:
        _connectionStateController.add(WsConnectionState.Connected);
        return;
      case WsMessageType.Message:
        _messageStream.add(WsMessageMessage.fromJson(jsonMessage));
        return;
    }
  }

  void _onDone() {
    _connectionStateController.add(WsConnectionState.Error);
  }

  Future<void> send(WsMessage message) async {}

  Future<void> _handleWsException(WebSocketChannelException e) async {
    Failure? f;

    f ??= Failure(status: FailureStatus.Unknown);

    _failureStream.add(f);
  }
}
