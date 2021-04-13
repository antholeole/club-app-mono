import 'dart:convert';
import 'dart:io';

import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;

class UnauthHttpClient extends HttpClient {
  @override
  Future<Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return super.throwIfNot2xx(await http.get(super.urlBuilder(endpoint)));
    } on SocketException catch (_) {
      throw HttpException(message: '', statusCode: 999, socketException: true);
    }
  }

  @override
  Future<Response> postReq(
      String endpoint, Map<String, dynamic>? jsonBody) async {
    try {
      return super.throwIfNot2xx(await http.post(super.urlBuilder(endpoint),
          body: json.encode(jsonBody)));
    } on SocketException catch (_) {
      throw HttpException(message: '', statusCode: 999, socketException: true);
    }
  }
}
