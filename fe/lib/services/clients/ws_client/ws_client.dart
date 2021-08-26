import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:web_socket_channel/io.dart';
import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:web_socket_channel/status.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

enum WsConnectionState { Connecting, Connected, Error }

class WsClient {
  static const DEFAULT_SCHEDULED_RECONNECT_WAIT = Duration(seconds: 5);

  final TokenManager _tokenManager = getIt<TokenManager>();
  final Config _config = getIt<Config>();
  final Handler _handler = getIt<Handler>();

  final StreamController<Failure> _failureStream = StreamController.broadcast();
  final StreamController<WsMessage> _messageStream =
      StreamController.broadcast();
  final StreamController<WsConnectionState> _connectionStateController =
      StreamController.broadcast();

  Timer? reinitalizeTimer;

  IOWebSocketChannel? _wsChannel;

  WsClient();

  Stream<WsConnectionState> get connectionState {
    return _connectionStateController.stream;
  }

  Stream<Failure> get failureStream {
    return _failureStream.stream;
  }

  Stream<WsMessage> get messageStream {
    return _messageStream.stream;
  }

  /// closes the connection and resets all stream controllers.
  /// because this object will live between closes (i.e. log in -> log out -> log in)
  /// we must allow the stream to be listened to again.
  Future<void> close() async {
    await _wsChannel?.sink.close(goingAway);
    reinitalizeTimer?.cancel();
  }

  Future<void> initalize() async {
    _connectionStateController.add(WsConnectionState.Connecting);

    WebSocket wsConn;

    String token;
    try {
      String? newToken = await _tokenManager.read();
      newToken ??= await _tokenManager.refresh();
      token = newToken;
    } on Failure catch (f) {
      _failureStream.add(f);
      _connectionStateController.add(WsConnectionState.Error);
      _scheduleReconnect();
      return;
    }

    try {
      wsConn = await WebSocket.connect(
        _config.wsUrl,
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      if (e is SocketException || e is WebSocketException) {
        _connectionStateController.add(WsConnectionState.Error);
        return _scheduleReconnect();
      }
      rethrow;
    }

    _connectionStateController.add(WsConnectionState.Connected);

    wsConn.pingInterval = const Duration(seconds: 20);
    _wsChannel = IOWebSocketChannel(wsConn);

    _wsChannel!.stream
        .listen(_onMessage, onError: _handleWsException, onDone: _onDone);

    reinitalizeTimer?.cancel();
    reinitalizeTimer = null;
  }

  void _onMessage(dynamic message) {
    final jsonMessage = json.decode(message);
    final wsMessageType = WsMessage.determineMessage(jsonMessage);

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

  Future<void> _onDone() async {
    await initalize();
  }

  void send(WsMessage message) {
    if (_wsChannel == null) {
      throw const Failure(
          status: FailureStatus.NoConn, message: 'not connected to server');
    }

    _wsChannel!.sink.add(json.encode(message.toJson()));
  }

  Future<void> _handleWsException(Object e) async {
    await _handler.reportUnknown(e);

    _failureStream.add(const Failure(status: FailureStatus.Unknown));
    await initalize();
  }

  void _scheduleReconnect(
      {Duration inDuration = DEFAULT_SCHEDULED_RECONNECT_WAIT}) {
    reinitalizeTimer = Timer(inDuration, () async {
      await initalize();
    });
  }
}
