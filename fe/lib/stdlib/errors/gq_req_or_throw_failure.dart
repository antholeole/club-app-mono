import 'package:ferry/ferry.dart';

import 'handle_gql_error.dart';

Future<TData> gqlReqOrThrowFailure<TData, TVars>(
    OperationRequest<TData, TVars> request, Client gqlClient) async {
  final resp = await gqlClient.request(request).first;

  if (resp.hasErrors) {
    throw await basicGqlErrorHandler(resp);
  }

  return resp.data!;
}
