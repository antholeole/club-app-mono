import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:gql_error_link/gql_error_link.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import '../../config.dart';
import '../../constants.dart';
import '../../service_locator.dart';

//todo: typedef GqlClient = Client;
Future<Client> buildGqlClient() async {
  final tokenManager = getIt<TokenManager>();

  //This is getting called before the refresh tokens are getting
  //inited due to dependency web :(
  final tokens = await tokenManager.read();

  final refreshLink = FreshLink.oAuth2(
    tokenHeader: (token) => {
      'Authorization': 'Bearer ${token?.accessToken}',
      'x-hasura-role': 'user'
    },
    shouldRefresh: (Response resp) => (resp.errors
            ?.firstWhere((element) => element.message.contains(JWT_EXPIRED)) !=
        null),
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

Stream<Response> handleException(Request req,
    Stream<Response> Function(Request) next, Response response) async* {
  throw await basicGqlErrorHandler(errors: response.errors);
}

Future<Failure> basicGqlErrorHandler({List<GraphQLError>? errors}) async {
  if (!(await HttpClient.isConnected())) {
    return Failure(message: "Couldn't connect to internet.");
  }

  try {
    await getIt<UnauthHttpClient>().getReq('/ping');
  } on HttpException catch (e) {
    if (e.socketException) {
      return Failure(
          message:
              "Sorry, looks like our servers are down - we're working on it!");
    }
  }

  if (errors != null) {
    StringBuffer errorBuff = StringBuffer();
    errors.forEach((error) {
      errorBuff.write(error.message);
      debugPrint('got GQL error: ${error.message}');
    });
    return Failure(message: errorBuff.toString());
  } else if (getIt<Config>().debug) {
    debugPrint('entered GQL error handler with errors = null');
    try {
      throw Error();
    } on Error catch (e) {
      print(e.stackTrace);
    }
  }

  return Failure(message: 'Unknown error.');
}
