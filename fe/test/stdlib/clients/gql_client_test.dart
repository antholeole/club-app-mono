import 'package:fe/config.dart';
import 'package:fe/constants.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/clients/gql_client/gql_client.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
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
      //TODO: why isn't this bouning back and recalling?
      final MockTokenManager mockTokenManager = MockTokenManager();
      final MockClient mockClient = MockClient();

      getIt.registerSingleton<TokenManager>(mockTokenManager);
      getIt.registerSingleton<http.Client>(mockClient);

      when(mockTokenManager.refresh()).thenAnswer(
          (_) => Future.value(OAuth2Token(accessToken: 'fake.access.token')));
      when(mockTokenManager.read()).thenAnswer((_) => Future.value(null));
      when(mockClient.send(any))
          .thenAnswer((_) => buildFailedGqlResponse([JWS_ERROR]));

      final client = await buildGqlClient();
      await client.request(GFakeGqlReq()).first;

      verify(mockTokenManager.refresh()).called(1);
    });

    test('should throw revoke error if refresh fails', () async {
      final MockTokenManager mockTokenManager = MockTokenManager();
      final MockClient mockClient = MockClient();

      getIt.registerSingleton<TokenManager>(mockTokenManager);
      getIt.registerSingleton<http.Client>(mockClient);

      when(mockTokenManager.refresh()).thenThrow(TokenException());
      when(mockTokenManager.read()).thenAnswer((_) => Future.value(null));
      when(mockClient.send(any))
          .thenAnswer((_) => buildFailedGqlResponse([JWS_ERROR]));

      final client = await buildGqlClient();

      final resp = await client.request(GFakeGqlReq()).first;

      expect(resp.graphqlErrors![0], isA<RevokeTokenException>());
    });

    //should attempt to read tokens

    //should be in auth mode if or if no tokens
  });
}
