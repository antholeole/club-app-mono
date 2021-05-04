import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:gql_error_link/gql_error_link.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_transform_link/gql_transform_link.dart';

import '../../config.dart';
import '../../constants.dart';
import '../../service_locator.dart';

//TODO: typedef GqlClient = Client;
Client buildGqlClient(LocalUser localUser) {
  final link = Link.from([
    _HttpAuthLink(localUser),
    HttpLink(getIt<Config>().gqlUrl),
  ]);

  return Client(link: link);
}

class _HttpAuthLink extends Link {
  late Link _link;
  LocalUser localUser;

  _HttpAuthLink(this.localUser) {
    _link = Link.concat(
      ErrorLink(onGraphQLError: handleException),
      TransformLink(requestTransformer: addHeaders),
    );
  }

  Request addHeaders(Request request) =>
      request.updateContextEntry<HttpLinkHeaders>(
        (headers) => HttpLinkHeaders(
          headers: <String, String>{
            ...headers?.headers ?? <String, String>{},
            'Authorization': 'Bearer ${localUser.accessToken}',
            'x-hasura-role': 'user'
          },
        ),
      );

  Stream<Response> handleException(Request request,
      Stream<Response> Function(Request) forward, Response resp) async* {
    if (resp.errors
            ?.firstWhere((element) => element.message.contains(JWT_EXPIRED)) !=
        null) {
      await updateToken();

      yield* forward(addHeaders(request));
    }

    throw await basicGqlErrorHandler(errors: resp.errors);
  }

  @override
  Stream<Response> request(Request request,
      [Stream<Response> Function(Request)? forward]) async* {
    yield* _link.request(request, forward);
  }

  Future<void> updateToken() async {
    await localUser.refreshAccessToken();
  }
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
    errors.forEach((error) {
      debugPrint('got GQL error: ${error.message}');
    });
    return Failure(message: 'Unknown GraphQL error.');
  }

  return Failure(message: 'Unknown error.');
}
