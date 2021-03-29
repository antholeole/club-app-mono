import 'package:fe/data_classes/local_user.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_error_link/gql_error_link.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_transform_link/gql_transform_link.dart';

import '../config.dart';
import '../constants.dart';
import '../service_locator.dart';

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

  Future<void> updateToken() async {
    await localUser.refreshAccessToken();
  }

  Stream<Response> handleException(Request request,
      Stream<Response> Function(Request) forward, Response resp) async* {
    if (resp.errors
            ?.firstWhere((element) => element.message.contains(JWT_EXPIRED)) !=
        null) {
      await updateToken();

      yield* forward(addHeaders(request));
    }

    final buildErrorString =
        resp.errors!.map((error) => error.message).join('", and "');

    throw Exception('gql errored with $buildErrorString');
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

  @override
  Stream<Response> request(Request request,
      [Stream<Response> Function(Request)? forward]) async* {
    yield* _link.request(request, forward);
  }
}
