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
import '../../pages/main/cubit/main_page_actions_cubit.dart';
import '../../service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../toaster.dart';

//todo: typedef GqlClient = Client;
Future<Client> buildGqlClient() async {
  final tokenManager = getIt<TokenManager>();

  //HACK: we need to have auth mode on, but it
  //doesn't activate until it has a token. If no token exists,
  //try to use a "dummy" one so that it gets rejected with JWS error
  //and refresh gets triggered.
  final tokens = await tokenManager.read() ??
      OAuth2Token(accessToken: 'a.a.a', expiresIn: 0);

  final refreshLink = FreshLink.oAuth2(
    tokenHeader: (token) => {
      'Authorization': 'Bearer ${token?.accessToken}',
      'x-hasura-role': 'user'
    },
    shouldRefresh: (Response resp) {
      return (resp.errors?.firstWhere((element) =>
              element.message.contains(JWT_EXPIRED) ||
              element.message.contains(JWS_ERROR)) !=
          null);
    },
    tokenStorage: InMemoryTokenStorage(),
    refreshToken: (_, __) => tokenManager.refresh(),
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

  if (errors != null) {
    StringBuffer errorBuff = StringBuffer();
    errors.forEach((error) {
      errorBuff.write(error.message);
      debugPrint('got GQL error: ${error.message}');
    });
    return Failure(
        message: errorBuff.toString(), status: FailureStatus.GQLMisc);
  } else {
    //HACK: https://github.com/felangel/fresh/issues/48
    return Failure(
        message: 'Access token refresh failed.',
        status: FailureStatus.GQLRefresh);
  }
}
