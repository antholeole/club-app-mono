import 'package:fe/stdlib/clients/gql_client/cache.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../constants.dart';
import '../../../service_locator.dart';
import '../../local_data/token_manager.dart';

//todo: typedef GqlClient = Client;
Future<Client> buildGqlClient() async {
  final tokenManager = getIt<TokenManager>();
  //HACK: we need to have auth mode on, but it
  //doesn't activate until it has a token. If no token exists,
  //try to use a "dummy" one so that it gets rejected with JWS error
  //and refresh gets triggered.
  final tokens = await tokenManager.read() ??
      OAuth2Token(accessToken: 'aa.aa.aa', expiresIn: 0);

  final refreshLink = FreshLink.oAuth2(
    tokenHeader: (token) => {
      'Authorization': 'Bearer ${token?.accessToken}',
      'x-hasura-role': 'user'
    },
    shouldRefresh: (Response resp) {
      for (final error in resp.errors ?? <GraphQLError>[]) {
        if (error.message.contains(JWT_EXPIRED)) {
          return true;
        } else if (error.message.contains(JWS_ERROR)) {
          return true;
        } else {
          debugPrint('Got gql error: $error');
        }
      }
      return false;
    },
    tokenStorage: InMemoryTokenStorage(),
    refreshToken: (_, __) async {
      try {
        return await tokenManager.refresh();
      } on TokenException catch (e) {
        debugPrint('caught err $e');
        throw RevokeTokenException(); //this does nothing?????
      }
    },
  );

  await refreshLink.setToken(tokens);

  final link = Link.from([
    refreshLink,
    HttpLink(getIt<Config>().gqlUrl, httpClient: getIt<http.Client>())
  ]);

  return Client(link: link, cache: await buildCache());
}
