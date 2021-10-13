import 'package:fe/services/clients/gql_client/gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void stubGqlResponse<TData, TVars>(GqlClient client,
    {TData Function(Invocation)? data,
    Failure Function(Invocation)? error,
    Matcher? requestMatcher}) {
  assert(
      data != null || error != null, 'one of data or errors must be provided');

  if (data != null) {
    when(() => client.request(any(that: requestMatcher))).thenAnswer(
        (invocation) => Stream.fromIterable([data.call(invocation)]));
  }

  if (error != null) {
    when(() => client.request(any(that: requestMatcher)))
        .thenAnswer((invocation) => throw error(invocation));
  }
}
