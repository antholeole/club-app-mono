import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import '../../../config.dart';

abstract class HttpClient {
  Future<http.Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters});

  Future<http.Response> postReq(
    String endpoint,
    Map<String, dynamic>? jsonBody,
  );

  static Future<Failure> basicHttpErrorHandler(HttpException e) async {
    if (e.socketException) {
      return const Failure(status: FailureStatus.ServersDown);
    }

    if (e.message == '') {
      if (!await isConnected()) {
        return const Failure(
          status: FailureStatus.NoConn,
        );
      }
    }

    if (e.statusCode == 500) {
      debugPrint('recieved 500 error');
      return const Failure(status: FailureStatus.InternalServerError);
    }
    var f = Failure(status: FailureStatus.Unknown, message: e.message);

    return f;
  }

  @protected
  Uri urlBuilder(String path, [Map<String, dynamic>? queryParameters]) {
    if (getIt<Config>().httpIsSecure) {
      return Uri.https(
          getIt<Config>().connectionUrl, '/api' + path, queryParameters);
    } else {
      return Uri.http(
          getIt<Config>().connectionUrl, '/api' + path, queryParameters);
    }
  }

  @protected
  http.Response throwIfNot2xx(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw HttpException(statusCode: resp.statusCode, message: resp.body);
    } else {
      return resp;
    }
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  final bool socketException;

  const HttpException(
      {required this.statusCode,
      required this.message,
      this.socketException = false});
}
