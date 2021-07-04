import 'dart:io';

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
    if (resp.linkException!.originalException is Failure) {
      return resp.linkException!.originalException;
    } else if (resp.linkException!.originalException is HttpException) {
      return HttpClient.basicHttpErrorHandler(
          resp.linkException!.originalException, {});
    }
  }

  if (!(await HttpClient.isConnected())) {
    return Failure(status: FailureStatus.NoConn);
  }

  final hasServerConnection =
      await getIt<UnauthHttpClient>().hasServerConnection();
  if (!hasServerConnection) {
    return Failure(status: FailureStatus.ServersDown);
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

  return Failure(status: FailureStatus.Unknown);
}
