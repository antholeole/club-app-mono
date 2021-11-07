import 'package:fe/stdlib/errors/handler.dart';
import 'package:ferry/ferry.dart';

import '../../../service_locator.dart';

class GqlClient {
  final _handler = getIt<Handler>();

  final Client _client;

  GqlClient({required Client client}) : _client = client;

  Stream<TData> request<TData, TVars>(OperationRequest<TData, TVars> request) {
    return _client.request(request).asyncMap((resp) async {
      if (resp.hasErrors) {
        throw await _handler.basicGqlErrorHandler(resp);
      } else {
        return resp.data!;
      }
    });
  }

  Cache get cache => _client.cache;
  Client get innerClient => _client;
}
