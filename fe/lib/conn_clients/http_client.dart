import 'package:fe/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config.dart';

class HttpClient {
  Uri _urlBuilder(String path, [Map<String, dynamic>? queryParameters]) {
    if (getIt<Config>().httpIsSecure) {
      return Uri.https(getIt<Config>().connectionUrl, path, queryParameters);
    } else {
      return Uri.http(getIt<Config>().connectionUrl, path, queryParameters);
    }
  }

  Future<http.Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters,
      bool authenticated = false}) async {
    return _throwIfNot2xx(await http.get(_urlBuilder(endpoint)));
  }

  Future<http.Response> postReq(String endpoint, Map<String, dynamic>? jsonBody,
      {bool authenticated = false}) async {
    return _throwIfNot2xx(
        await http.post(_urlBuilder(endpoint), body: json.encode(jsonBody)));
  }

  http.Response _throwIfNot2xx(http.Response resp) {
    if (resp.statusCode < 200 || resp.statusCode > 299) {
      throw HttpException(statusCode: resp.statusCode, message: resp.body);
    } else {
      return resp;
    }
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  const HttpException({required this.statusCode, required this.message});
}
