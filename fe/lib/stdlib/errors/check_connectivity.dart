import 'package:fe/stdlib/clients/http_client/http_client.dart';
import 'package:fe/stdlib/clients/http_client/unauth_http_client.dart';

import '../../service_locator.dart';
import 'failure.dart';
import 'failure_status.dart';

Future<Failure?> checkConnecivity() async {
  if (!(await HttpClient.isConnected())) {
    return Failure(status: FailureStatus.NoConn);
  }

  final hasServerConnection =
      await getIt<UnauthHttpClient>().hasServerConnection();
  if (!hasServerConnection) {
    return Failure(status: FailureStatus.ServersDown);
  }
}
