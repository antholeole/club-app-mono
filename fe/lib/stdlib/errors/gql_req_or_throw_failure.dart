import 'package:fe/stdlib/errors/handler.dart';
import 'package:ferry/ferry.dart';

import '../../service_locator.dart';

Future<TData> gqlReqOrThrowFailure<TData, TVars>(
    OperationRequest<TData, TVars> request, Client gqlClient) async {
  final resp = await gqlClient.request(request).first;

  if (resp.hasErrors) {
    throw await getIt<Handler>().basicGqlErrorHandler(resp);
  }

  return resp.data!;
}
