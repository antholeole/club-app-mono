import 'dart:async';

import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fe/gql/fake/fake.data.gql.dart';
import 'package:fe/gql/fake/fake.var.gql.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/fixtures/mocks.dart';
import '../../test_helpers/get_it_helpers.dart';
import '../../test_helpers/pump_app.dart';
import '../../test_helpers/stub_gql_response.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<OperationRequest<GFakeGqlData, GFakeGqlVars>>(
        FakeRequest<GFakeGqlData, GFakeGqlVars>());
  });

  setUp(() {
    registerAllMockServices();
  });
  group('loader', () {
    //required so we can complete the future to clean up
    late Completer<OperationResponse<GFakeGqlData, GFakeGqlVars>> respCompleter;

    setUp(() {
      respCompleter = Completer();

      when(() => getIt<Client>().request<GFakeGqlData, GFakeGqlVars>(any()))
          .thenAnswer((_) => Stream.fromFuture(respCompleter.future));
    });

    tearDown(() {
      respCompleter.complete(OperationResponse<GFakeGqlData, GFakeGqlVars>(
          operationRequest: FakeRequest<GFakeGqlData, GFakeGqlVars>(),
          data: GFakeGqlData.fromJson({'group_join_tokens': []})));
    });

    testWidgets('should build custom loader on loader', (tester) async {
      const loaderKey = Key('loaderkey');

      await tester.pumpApp(GqlOperation(
        onResponse: (_) => Container(),
        loader: Container(
          key: loaderKey,
        ),
        operationRequest: GFakeGqlReq(),
      ));

      expect(find.byKey(loaderKey), findsOneWidget);
    });

    testWidgets('should build standard loader on no loader', (tester) async {
      await tester.pumpApp(GqlOperation(
        onResponse: (_) => Container(),
        operationRequest: GFakeGqlReq(),
      ));

      expect(find.byType(Loader), findsOneWidget);
    });
  });

  group('on error', () {
    const fakeFailure = Failure(status: FailureStatus.GQLMisc);

    testWidgets('should call basic GQL error handler', (tester) async {
      stubGqlResponse<GFakeGqlData, GFakeGqlVars>(getIt<Client>(),
          errors: (_) => [const GraphQLError(message: 'msg')]);

      when(() => getIt<Handler>().basicGqlErrorHandler(any()))
          .thenAnswer((_) async => fakeFailure);

      await tester.pumpApp(GqlOperation(
        onResponse: (_) => Container(),
        operationRequest: GFakeGqlReq(),
      ));

      await tester.pump();

      verify(() => getIt<Handler>().basicGqlErrorHandler(any())).called(1);
      verify(() => getIt<Handler>().handleFailure(any(), any())).called(1);
    });

    testWidgets('should attempt to return value from cache', (tester) async {
      const renderKey = Key('value');

      final req = GFakeGqlReq();

      final gqlStreamController =
          StreamController<OperationResponse<GFakeGqlData, GFakeGqlVars>>();
      when(() => getIt<Client>().request(any()))
          .thenAnswer((_) => gqlStreamController.stream);

      when(() => getIt<Handler>().basicGqlErrorHandler(any()))
          .thenAnswer((_) async => fakeFailure);

      await tester.pumpApp(GqlOperation(
        onResponse: (_) => Container(
          key: renderKey,
        ),
        operationRequest: req,
      ));

      gqlStreamController.add(OperationResponse<GFakeGqlData, GFakeGqlVars>(
          operationRequest: req,
          dataSource: DataSource.Cache,
          data: GFakeGqlData.fromJson({'group_join_tokens': []})!));

      await tester.pump();

      await expectLater(find.byKey(renderKey), findsOneWidget);

      gqlStreamController.add(OperationResponse<GFakeGqlData, GFakeGqlVars>(
          dataSource: DataSource.Link,
          linkException:
              const FakeLinkException(GraphQLError(message: 'fakeError')),
          operationRequest: req,
          graphqlErrors: [const GraphQLError(message: 'fakeError')]));

      await tester.pump();

      expect(find.byKey(renderKey), findsOneWidget,
          reason: 'even on error, should render from cache');
    });
  });

  group('operation request prop', () {
    testWidgets('if not passed in should render loader', (tester) async {
      const renderKey = Key('value');

      await tester.pumpApp(GqlOperation(
        loader: Container(
          key: renderKey,
        ),
        onResponse: (_) => Container(),
      ));

      await tester.pump();

      expect(find.byKey(renderKey), findsOneWidget);
    });
  });
}
