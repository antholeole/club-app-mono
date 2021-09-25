import 'package:fe/stdlib/errors/handler.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../service_locator.dart';
import 'cache.dart';
import 'gql_client.dart';

class UnauthGqlClient extends GqlClient {
  UnauthGqlClient._({required Client client}) : super(client: client);

  static Future<UnauthGqlClient> build() async {
    final config = getIt<Config>();

    final link = HttpLink(
        Uri(
                host: config.hasuraHost,
                pathSegments: config.gqlPathSegments,
                port: config.hasuraPort,
                scheme: config.transportIsSecure ? 'https' : 'http')
            .toString(),
        httpClient: getIt<http.Client>());

    return UnauthGqlClient._(
        client: Client(link: link, cache: await buildCache(memoryCache: true)));
  }
}
