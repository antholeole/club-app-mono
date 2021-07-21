import 'dart:async';

import 'package:fe/pages/main/main_helpers/ws/ws_provider.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/helpers/size_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WsReactor extends StatefulWidget {
  static const double _ESTIMATED_HEIGHT = 20.0;

  static const int _INITAL_CHECK_TIME_SECONDS = 6;
  static const int _SHOW_AFTER_CONNECTED_SECONDS = 4;

  final void Function(double) _sizeCallback;

  const WsReactor({required void Function(double) sizeCallback})
      : _sizeCallback = sizeCallback;

  @override
  _WsReactorState createState() => _WsReactorState();
}

class _WsReactorState extends State<WsReactor> {
  late Timer _intitalConnectionTimer;

  bool _isSubscribed = false;
  bool _shouldShow = false;

  WsConnectionState _currentConnectionState = WsConnectionState.Connecting;

  @override
  void initState() {
    _intitalConnectionTimer = Timer(
        const Duration(seconds: WsReactor._INITAL_CHECK_TIME_SECONDS),
        _checkShow);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isSubscribed) {
      final ws = WsProvider.of(context)!.wsClient;
      ws.connectionState().listen(_respondToConnectionStates);
      ws.errorStream().listen(_respondToFailures);
      _isSubscribed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) {
      return _buildEmpty();
    }

    switch (_currentConnectionState) {
      case WsConnectionState.Error:
        return _buildSnackBar(Colors.red, "Couldn't establish connection.");
      case WsConnectionState.Connected:
        return _buildSnackBar(Colors.green, 'Connected!');
      case WsConnectionState.Connecting:
        return _buildSnackBar(Colors.deepOrange, 'Establishing connection...');
    }
  }

  void _checkShow() {
    switch (_currentConnectionState) {
      case WsConnectionState.Error:
      case WsConnectionState.Connecting:
        setState(() {
          _shouldShow = true;
        });
        break;
      case WsConnectionState.Connected:
        setState(() {
          _shouldShow = false;
        });
        break;
    }
  }

  void _respondToConnectionStates(WsConnectionState connectionState) {
    print('hi');
    if (_shouldShow && connectionState == WsConnectionState.Connected) {
      if (_shouldShow) {
        Timer(
          const Duration(seconds: WsReactor._SHOW_AFTER_CONNECTED_SECONDS),
          () => setState(() {
            _shouldShow = false;
          }),
        );
      }
    }

    if (!_intitalConnectionTimer.isActive &&
        (connectionState == WsConnectionState.Error ||
            connectionState == WsConnectionState.Connecting)) {
      setState(() {
        _shouldShow = true;
      });
    }

    setState(() {
      _currentConnectionState = connectionState;
    });
  }

  void _respondToFailures(Failure f) {
    handleFailure(f, context, toast: false);
  }

  Widget _buildEmpty() {
    widget._sizeCallback(0);
    return Container();
  }

  Widget _buildSnackBar(Color bgColor, String text) {
    widget._sizeCallback(WsReactor._ESTIMATED_HEIGHT);

    return SizeProviderWidget(
        onChildSize: (size) => widget._sizeCallback(size.height),
        child: Container(
            width: double.infinity,
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white, fontSize: 12.0)),
            )));
  }
}
