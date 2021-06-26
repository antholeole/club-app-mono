import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:flutter/widgets.dart';

class WsProvider extends InheritedWidget {
  final WsClient wsClient;

  const WsProvider({
    required Widget child,
    required this.wsClient,
  }) : super(child: child);

  static WsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WsProvider>();
  }

  @override
  bool updateShouldNotify(WsProvider old) => false;
}
