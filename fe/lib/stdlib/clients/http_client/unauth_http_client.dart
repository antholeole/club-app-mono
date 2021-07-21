import 'dart:convert';
import 'package:fe/service_locator.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import './http_client.dart';

class UnauthHttpClient extends HttpClient {
  final _httpClient = getIt<http.Client>();

  @override
  Future<Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    return super
        .throwIfNot2xx(await _httpClient.get(super.urlBuilder(endpoint)));
  }

  @override
  Future<Response> postReq(
      String endpoint, Map<String, dynamic>? jsonBody) async {
    return super.throwIfNot2xx(await _httpClient
        .post(super.urlBuilder(endpoint), body: json.encode(jsonBody)));
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
