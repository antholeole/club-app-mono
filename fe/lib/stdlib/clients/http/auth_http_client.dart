import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/clients/http/http_client.dart';
import 'package:http/src/response.dart';

class AuthHttpClient extends HttpClient {
  LocalUser _localUser = getIt<LocalUser>();

  AuthHttpClient();

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
