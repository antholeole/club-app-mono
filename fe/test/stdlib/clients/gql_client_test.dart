import 'package:fe/config.dart';
import 'package:fe/constants.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/clients/gql_client/gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../test_helpers/mock_http_client.dart';
import '../../test_helpers/testing_config.dart';
import 'gql_client_test.mocks.dart';

@GenerateMocks([TokenManager, http.Client])
void main() {
  group('buildGqlClient', () {
    setUp(() {
      getIt.registerSingleton<Config>(TestingConfig());
    });

    tearDown(() {
      getIt.reset();
    });

    test('should use refresh token when expired or no token', () async {
      final MockTokenManager mockTokenManager = MockTokenManager();
      final MockClient mockClient = MockClient();

      getIt.registerSingleton<TokenManager>(mockTokenManager);
      getIt.registerSingleton<http.Client>(mockClient);

      when(mockTokenManager.refresh())
          .thenAnswer((_) => Future.value('fake.access.token'));
      when(mockTokenManager.read()).thenAnswer((_) => Future.value(null));
      when(mockClient.send(any))
          .thenAnswer((_) => buildFailedGqlResponse([JWS_ERROR]));

      final client = await buildGqlClient();
      await client.request(GFakeGqlReq()).first;

      verify(mockTokenManager.refresh()).called(1);
      verify(mockClient.send(any))
          .called(2); //one fails, second works b/c new token
    });

    test('should throw revoke error if refresh fails', () async {});
  });
}
