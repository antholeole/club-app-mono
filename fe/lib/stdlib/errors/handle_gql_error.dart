import 'package:fe/services/clients/http_client/http_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:ferry/ferry.dart';
import 'check_connectivity.dart';

Future<Failure> basicGqlErrorHandler(OperationResponse resp) async {
  final errors = resp.graphqlErrors;

  if (resp.linkException != null) {
    if (resp.linkException!.originalException is Failure) {
      return resp.linkException!.originalException;
    } else if (resp.linkException!.originalException is HttpException) {
      return HttpClient.basicHttpErrorHandler(
          resp.linkException!.originalException);
    }
  }

  if (errors != null) {
    StringBuffer errorBuff = StringBuffer();
    errors.forEach((error) {
      errorBuff.write(error.message);
    });
    return Failure(
        message: errorBuff.toString(), status: FailureStatus.GQLMisc);
  }

  final disconnectedFailure = await checkConnecivity();

  if (disconnectedFailure != null) {
    return disconnectedFailure;
  }

  return const Failure(status: FailureStatus.Unknown);
}
