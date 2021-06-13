import 'package:fe/stdlib/clients/http_client/http_client.dart';
import 'package:fe/stdlib/clients/http_client/unauth_http_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

Future<Failure> basicGqlErrorHandler(OperationResponse resp) async {
  final errors = resp.graphqlErrors;

  if (resp.linkException != null) {
    if (resp.linkException!.originalException is TokenException) {
      return Failure(
          status: FailureStatus.GQLRefresh,
          message: 'failed to refresh token',
          resolved: false);
    } else {
      debugPrint('got a linkex but it isnt a revoke token ex');
    }
  }

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
  }

  debugPrint('entered gql error handler with errors = null');
  return Failure(message: 'Unknown error', status: FailureStatus.Unknown);
}
