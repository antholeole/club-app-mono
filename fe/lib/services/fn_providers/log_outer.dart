import 'package:fe/flows/app_state.dart';
import 'package:fe/services/clients/notification_client/notification_client.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/src/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../service_locator.dart';

class LogOuter {
  final Future<void> Function({String? withError}) logOut;

  const LogOuter({required this.logOut});
}

/// needs to be hosted high up the widget tree
/// because many widgets may force a log out;
class LogOutRunner extends StatelessWidget {
  static const String LOGOUT_COPY = 'Logged Out.';

  final _localFileStore = getIt<LocalFileStore>();
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _tokenManager = getIt<TokenManager>();
  final _notificationClient = getIt<NotificationClient>();
  final _handler = getIt<Handler>();

  final Widget _child;

  LogOutRunner({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LogOuter>(
      child: _child,
      create: (context) => LogOuter(
          logOut: ({String? withError}) =>
              _logOut(context, withError: withError)),
    );
  }

  Future<void> _logOut(BuildContext context, {String? withError}) async {
    final forced = withError != null;

    try {
      await _notificationClient.removeDeviceToken(failSilently: forced);
    } on Failure catch (f) {
      //removeDeviceToken can only error if failSilently is true;
      //thus, we will only fail to log out if we manually attempt logout.
      _handler.handleFailure(f, context, withPrefix: 'failed to log out');
      return;
    }

    await Future.wait([
      _localFileStore.delete(LocalStorageType.LocalUser),
      _secureStorage.deleteAll(),
      _tokenManager.delete()
    ]);
    Sentry.configureScope((scope) => scope.user = null);

    if (withError != null) {
      context.read<ToasterCubit>().add(Toast(
          message: "Sorry, you've been logged out due to an error: $withError",
          type: ToastType.Error));
    } else {
      context
          .read<ToasterCubit>()
          .add(Toast(message: LOGOUT_COPY, type: ToastType.Warning));
    }

    context.flow<AppState>().update((_) => const AppState.needLogin());
  }
}
