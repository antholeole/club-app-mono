import 'dart:convert';
import 'dart:io';

import 'package:fe/service_locator.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import './http_client.dart';

class UnauthHttpClient extends HttpClient {
  final _httpClient = getIt<http.Client>();

  @override
  Future<Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return super
          .throwIfNot2xx(await _httpClient.get(super.urlBuilder(endpoint)));
    } on SocketException catch (_) {
      throw const HttpException(
          message: '', statusCode: 999, socketException: true);
    }
  }

  @override
  Future<Response> postReq(
      String endpoint, Map<String, dynamic>? jsonBody) async {
    try {
      return super.throwIfNot2xx(await _httpClient
          .post(super.urlBuilder(endpoint), body: json.encode(jsonBody)));
    } on SocketException catch (_) {
      throw HttpException(message: '', statusCode: 999, socketException: true);
    }
  }

  Future<bool> hasServerConnection() async {
    try {
      await getReq('/ping');
      return true;
    } catch (e) {
      return false;
    }
  }
}
