import 'dart:io';

import 'package:fe/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'dart:convert';

import '../../config.dart';

import '../errors/failure.dart';

class HttpClient {
  Uri _urlBuilder(String path, [Map<String, dynamic>? queryParameters]) {
    if (getIt<Config>().httpIsSecure) {
      return Uri.https(
          getIt<Config>().connectionUrl, '/api' + path, queryParameters);
    } else {
      return Uri.http(
          getIt<Config>().connectionUrl, '/api' + path, queryParameters);
    }
  }

  Future<http.Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return _throwIfNot2xx(await http.get(_urlBuilder(endpoint)));
    } on SocketException catch (_) {
      throw HttpException(message: '', statusCode: 999, socketException: true);
    }
  }

  Future<http.Response> postReq(
    String endpoint,
    Map<String, dynamic>? jsonBody,
  ) async {
    try {
      return _throwIfNot2xx(
          await http.post(_urlBuilder(endpoint), body: json.encode(jsonBody)));
    } on SocketException catch (_) {
      throw HttpException(message: '', statusCode: 999, socketException: true);
    }
  }

  http.Response _throwIfNot2xx(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw HttpException(statusCode: resp.statusCode, message: resp.body);
    } else {
      return resp;
    }
  }
}

Future<Failure> basicErrorHandler(
    HttpException e, Map<int, String> extraErrors) async {
  if (e.socketException) {
    return Failure(
        message: "Couldn't connect to our servers. Please try again soon.");
  }

  if (e.message == '') {
    if (!await _isConnected()) {
      return Failure(message: "Couldn't connect to internet.");
    }
  }

  if (e.statusCode == 500) {
    debugPrint('recieved 500: ${e.message}');
    return Failure(
        message:
            'Sorry! We had an internal server error performing that action.');
  }
  var f = Failure(message: 'Unknown Error', resolved: false);

  extraErrors.forEach((code, error) {
    if (code == e.statusCode) {
      f = Failure(message: error, resolved: true);
    }
  });

  return f;
}

Future<bool> _isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  //true if no server connection could be established - our fault
  final bool socketException;

  const HttpException(
      {required this.statusCode,
      required this.message,
      this.socketException = false});
}
