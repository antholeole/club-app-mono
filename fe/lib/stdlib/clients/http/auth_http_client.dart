import 'package:fe/data_classes/local_user.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:http/src/response.dart';

class AuthHttpClient extends HttpClient {
  AuthHttpClient(LocalUser user);

  @override
  Future<Response> getReq(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    // TODO: implement getReq
    throw UnimplementedError();
  }

  @override
  Future<Response> postReq(String endpoint, Map<String, dynamic>? jsonBody) {
    // TODO: implement postReq
    throw UnimplementedError();
  }
}
