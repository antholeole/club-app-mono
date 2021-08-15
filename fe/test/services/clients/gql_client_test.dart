import 'dart:convert';

import 'package:fe/constants.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/gql_client.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/get_it_helpers.dart';

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
  group('buildGqlClient', () {
    setUp(() {
      registerAllServices();
    });

    test('should use refresh token when expired or no token', () async {
      int httpCallCount = 0;

      when(() => getIt<http.Client>().send(any())).thenAnswer((invocation) {
        httpCallCount++;
        return buildFailedGqlResponse([JWS_ERROR]);
      });

      when(() => getIt<TokenManager>().refresh())
          .thenAnswer((_) => Future.value('fake.access.token'));
      when(() => getIt<TokenManager>().read())
          .thenAnswer((_) => Future.value(null));

      final client = await buildGqlClient();
      await client.request(GFakeGqlReq()).first;

      verify(() => getIt<TokenManager>().refresh()).called(1);
      expect(httpCallCount, equals(2),
          reason: 'should recall http after refresh');
    });

    test('should throw revoke error if refresh fails', () async {});
  });
}
