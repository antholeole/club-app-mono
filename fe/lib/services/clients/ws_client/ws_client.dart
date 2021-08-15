import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/check_connectivity.dart';
import 'package:web_socket_channel/io.dart';
import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/errors/failure.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

enum WsConnectionState { Connecting, Connected, Error }

class WsClient {
  final TokenManager _tokenManager = getIt<TokenManager>();
  final Config _config = getIt<Config>();

  final StreamController<Failure> _failureStream = StreamController.broadcast();
  final StreamController<WsMessage> _messageStream =
      StreamController.broadcast();
  final StreamController<WsConnectionState> _connectionStateController =
      StreamController.broadcast();

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

  /// closes the connection and resets all stream controllers.
  /// because this object will live between closes (i.e. log in -> log out -> log in)
  /// we must allow the stream to be listened to again.
  Future<void> close() async {
    if (_wsChannel != null) {
      await _wsChannel!.sink.close();
    }
  }

  Future<void> initalize() async {
    _connectionStateController.add(WsConnectionState.Connecting);

    WebSocket wsConn;

    try {
      wsConn = await WebSocket.connect(
        _config.wsUrl,
        headers: {'Authorization': 'Bearer ${await _tokenManager.read()}'},
      );
    } on SocketException {
      _connectionStateController.add(WsConnectionState.Error);
      return _handleConnectionError();
    }

    _connectionStateController.add(WsConnectionState.Connected);

    wsConn.pingInterval = const Duration(seconds: 20);
    _wsChannel = IOWebSocketChannel(wsConn);

    _wsChannel!.stream
        .listen(_onMessage, onError: _handleWsException, onDone: _onDone);
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

  Future<void> _handleWsException(Object e) async {
    print(e);
    Failure? f;

    f ??= const Failure(status: FailureStatus.Unknown);

    _failureStream.add(f);
  }

  Future<void> _handleConnectionError() async {
    if (await checkConnecivity() != null) {
      Timer(const Duration(seconds: 5), initalize);
    }
  }
}
