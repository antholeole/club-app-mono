import 'package:fe/services/clients/gql_client/gql_client.dart';
import 'package:fe/services/clients/gql_client/refresh_link.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';
import 'package:normalize/utils.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import '../../../config.dart';
import '../../../service_locator.dart';
import 'cache.dart';

class AuthGqlClient extends GqlClient {
  AuthGqlClient._({required Client client}) : super(client: client);

  static Future<AuthGqlClient> build() async {
    final config = getIt<Config>();

    final link = Link.from([
      RefresherLink(),
      Link.split(
        (request) =>
            getOperationDefinition(
              request.operation.document,
              request.operation.operationName,
            ).type ==
            OperationType.subscription,
        WebSocketLink(null, channelGenerator: () async {
          if (!await getIt<TokenManager>().tokenIsValid()) {
            await getIt<TokenManager>().refresh();
          }

          return IOWebSocketChannel.connect(
              Uri(
                  host: config.hasuraHost,
                  pathSegments: config.gqlPathSegments,
                  port: config.hasuraPort,
                  scheme: config.transportIsSecure ? 'wss' : 'ws'),
              headers: {
                'Authorization': 'Bearer  ${await getIt<TokenManager>().read()}'
              });
        }),
      ),
      HttpLink(
          Uri(
                  host: config.hasuraHost,
                  pathSegments: config.gqlPathSegments,
                  port: config.hasuraPort,
                  scheme: config.transportIsSecure ? 'https' : 'http')
              .toString(),
          httpClient: getIt<http.Client>()),
    ]);

    return AuthGqlClient._(
        client: Client(defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheAndNetwork
    }, link: link, cache: await buildCache(memoryCache: false)));
  }
}
