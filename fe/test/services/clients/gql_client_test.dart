import 'dart:convert';

import 'package:fe/constants.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/get_it_helpers.dart';
import '../../test_helpers/path_provider_setup.dart';

Future<http.StreamedResponse> buildFailedGqlResponse(List<String> errors) {
  final errorResp = {
    'errors': errors.map((e) => {'message': e}).toList()
  };

  return Future<http.StreamedResponse>.value(
    http.StreamedResponse(
      Stream.value(utf8.encode(jsonEncode(errorResp))),
      200,
    ),
  );
}

void main() {
  final pathProviderSetups = pathProviderSetup('gql_client_test');

  setUpAll(() async {
    await pathProviderSetups[0]();
  });

  tearDownAll(() async {
    await pathProviderSetups[1]();
  });

  group('buildGqlClient', () {
    setUp(() {
      registerAllMockServices();
    });

    test('should use refresh token when expired or no token', () async {
      int httpCallCount = 0;

      final responses = [
        buildFailedGqlResponse([JWS_ERROR]),
        Future<http.StreamedResponse>.value(http.StreamedResponse(
          Stream.value(utf8.encode(jsonEncode({
            'data': {'group_join_tokens': []}
          }))),
          200,
        ))
      ];

      when(() => getIt<http.Client>().send(any())).thenAnswer((invocation) {
        httpCallCount++;
        return responses.removeAt(0);
      });

      when(() => getIt<TokenManager>().refresh())
          .thenAnswer((_) => Future.value('fake.access.token'));
      when(() => getIt<TokenManager>().read())
          .thenAnswer((_) => Future.value(null));

      final client = await AuthGqlClient.build();

      await client.request(GFakeGqlReq()).first;

      verify(() => getIt<TokenManager>().refresh()).called(1);
      expect(httpCallCount, equals(2),
          reason: 'should recall http after refresh');
    });
  });
}
