import 'package:fe/services/clients/gql_client/refresh_link.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../service_locator.dart';
import 'cache.dart';

class GqlClient {
  final _handler = getIt<Handler>();

  final Client _client;

  GqlClient._({required Client client}) : _client = client;

  static Future<GqlClient> build() async {
    final link = Link.from([
      RefresherLink(),
      HttpLink(getIt<Config>().gqlUrl, httpClient: getIt<http.Client>()),
    ]);

    return GqlClient._(
        client:
            Client(link: link, cache: await buildCache(memoryCache: false)));
  }

  Cache get cache => _client.cache;
  Client get innerClient => _client;

  Future<TData> request<TData, TVars>(
      OperationRequest<TData, TVars> request) async {
    final resp = await _client.request(request).first;

    if (resp.hasErrors) {
      throw await _handler.basicGqlErrorHandler(resp);
    }

    return resp.data!;
  }
}
