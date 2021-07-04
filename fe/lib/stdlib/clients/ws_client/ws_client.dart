import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fe/data/ws_message/ws_message.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

class WsClient {
  final TokenManager _tokenManager = getIt<TokenManager>();
  final Config _config = getIt<Config>();
  IOWebSocketChannel? _wsChannel;

  //when set, will block this instance of ws client from retrying
  //unless .connect is called explictly.
  Failure? _connectFailed;
  Future<void>? _futureChannelInitalization;

  WsClient(String initalAToken) {
    _initalize(initalAToken);
  }

  void _handleMessages(dynamic message) {
    print(message);
  }

  void _onError(Object error) {
    if (error is WebSocketChannelException &&
        error.inner is WebSocketException) {
    } else {
      print(error);
    }
  }

  Future<void> _initalize(String aToken, {int secondsDelay = 0}) async {
    try {
      _wsChannel = IOWebSocketChannel.connect(Uri.parse(_config.wsUrl),
          headers: {'Authorization': 'Bearer $aToken'});

      _wsChannel!.stream
          .listen(_handleMessages, onError: _onError, cancelOnError: false);
    } on WebSocketChannelException catch (e) {
      if (e.inner is WebSocketException) {
        final wse = e.inner as WebSocketException;
        if (wse.message.contains('WAS NOT UPGRADED')) {
          //failure to upgrade. generally means access token is expired
          try {
            final aToken = await _tokenManager.refresh();
            _futureChannelInitalization = _initalize(aToken);
          } on Failure catch (f) {
            _connectFailed = f;
          }
        }
      } else if (e.inner is SocketException) {
        _futureChannelInitalization = _initalize(aToken, secondsDelay: 5);
      }
    }
  }

  Future<void> send(WsMessage message) async {
    if (_connectFailed != null) {
      throw _connectFailed!;
    }

    if (_futureChannelInitalization != null) {
      await _futureChannelInitalization;
    }

    if (_wsChannel != null) {
      _wsChannel!.sink.add(json.encode(message.toJson()));
    }
  }
}
