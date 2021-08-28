import 'package:fe/services/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';

import '../../../constants.dart';
import '../../../service_locator.dart';

//copied from fresh_link
class RefresherLink extends Link {
  final _tokenManager = getIt<TokenManager>();

  Future<Map<String, String>> _buildTokenHeader() async {
    final token = _tokenManager.read();

    return {
      'Authorization': 'Bearer ${await _tokenManager.read()}',
      'x-hasura-role': 'user'
    };
  }

  bool _shouldRefresh(Response resp) {
    for (final error in resp.errors ?? <GraphQLError>[]) {
      if (error.message.contains(JWT_EXPIRED)) {
        return true;
      } else if (error.message.contains(JWS_ERROR)) {
        return true;
      }
    }
    return false;
  }

  Future<Request> _updateRequestHeaders(Request request) async {
    final tokenHeaders = await _buildTokenHeader();

    final updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: {
          ...headers?.headers ?? <String, String>{},
        }..addAll(tokenHeaders),
      ),
    );

    return updatedRequest;
  }

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final updatedRequest = await _updateRequestHeaders(request);

    if (forward != null) {
      await for (final result in forward(updatedRequest)) {
        if (_shouldRefresh(result)) {
          await _tokenManager.refresh();
          yield* forward(await _updateRequestHeaders(request));
        } else {
          yield result;
        }
      }
    }
  }
}
