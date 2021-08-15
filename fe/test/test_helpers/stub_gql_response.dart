import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';
import 'fixtures/mocks.dart';

void stubGqlResponse<TData, TVars>(Client client,
    {TData Function(Invocation)? data,
    List<GraphQLError> Function(Invocation)? errors,
    Matcher? requestMatcher}) {
  assert((data != null || errors != null) && (data == null || errors == null),
      'one and only one of data or errors must be provided');

  when(() => client.request(any(that: requestMatcher))).thenAnswer(
      (invocation) => Stream<OperationResponse<TData, TVars>>.fromIterable([
            OperationResponse(
                operationRequest: MockRequest<TData, TVars>(),
                data: data?.call(invocation),
                graphqlErrors: errors?.call(invocation),
                linkException:
                    errors != null ? FakeLinkException(Exception()) : null)
          ]));
}
