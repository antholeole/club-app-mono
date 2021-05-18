import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import '../../config.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../service_locator.dart';
import '../local_data/token_manager.dart';
import '../local_data/token_manager.dart';

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
        throw RevokeTokenException();
      }
    },
  );

  await refreshLink.setToken(tokens);

  final link = Link.from([
    refreshLink,
    HttpLink(getIt<Config>().gqlUrl),
  ]);

  return Client(link: link);
}

Future<Failure> basicGqlErrorHandler({List<GraphQLError>? errors}) async {
  if (!(await HttpClient.isConnected())) {
    return Failure(
        message: "Couldn't connect to internet.", status: FailureStatus.NoConn);
  }

  try {
    await getIt<UnauthHttpClient>().getReq('/ping');
  } on HttpException catch (e) {
    if (e.socketException) {
      return Failure(
          message:
              "Sorry, looks like our servers are down - we're working on it!",
          status: FailureStatus.ServersDown);
    }
  }

  if (errors != null && errors[0] is RevokeTokenException) {
    return Failure(
        message: 'Access token refresh failed.',
        status: FailureStatus.GQLRefresh);
  } else if (errors != null) {
    StringBuffer errorBuff = StringBuffer();
    errors.forEach((error) {
      errorBuff.write(error.message);
      debugPrint('got GQL error: ${error.message}');
    });
    return Failure(
        message: errorBuff.toString(), status: FailureStatus.GQLMisc);
  }

  debugPrint('entered gql error with errors = null');
  return Failure(message: 'Unknown error', status: FailureStatus.Unknown);
}
