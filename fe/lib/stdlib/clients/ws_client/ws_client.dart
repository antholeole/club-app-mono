import 'dart:async';
import 'dart:io';

import 'package:fe/stdlib/clients/http_client/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

import '../http_client/http_client.dart';
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
  final StreamController<WsConnectionState> connectionStateController =
      StreamController();

  IOWebSocketChannel? _wsChannel;

  WsClient();

  Stream<WsConnectionState> connectionState() {
    return connectionStateController.stream;
  }

  Stream<Failure> errorStream() {
    return _failureStream.stream;
  }

  Future<void> initalize() async {
    connectionStateController.add(WsConnectionState.Connecting);

    _wsChannel = IOWebSocketChannel.connect(Uri.parse(_config.wsUrl),
        headers: {'Authorization': 'Bearer ${await _tokenManager.read()}'});

    _wsChannel!.stream.listen(print, onError: print);
  }

  Future<void> send(WsMessage message) async {}

  Future<Failure> _handleWsException(WebSocketChannelException e) async {
    if (e.inner is WebSocketException) {
      final wse = e.inner as WebSocketException;
      if (wse.message.contains('WAS NOT UPGRADED')) {
        //failure to upgrade. generally means access token is expired
        try {
          await _tokenManager.refresh();
          await initalize();
        } on Failure catch (f) {
          return f;
        }
      }
    }

    if (!(await HttpClient.isConnected())) {
      return Failure(status: FailureStatus.NoConn);
    }

    final hasServerConnection = await _unauthHttpClient.hasServerConnection();
    if (!hasServerConnection) {
      return Failure(status: FailureStatus.ServersDown);
    }

    return Failure(status: FailureStatus.Unknown);
  }
}
