import 'package:fe/services/clients/gql_client/refresh_link.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../service_locator.dart';
import 'cache.dart';

//todo: typedef GqlClient = Client;
Future<Client> buildGqlClient() async {
  final link = Link.from([
    RefresherLink(),
    HttpLink(getIt<Config>().gqlUrl, httpClient: getIt<http.Client>()),
  ]);

  return Client(link: link, cache: await buildCache());
}
