import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';

import '../../../../../../test_helpers/get_it_helpers.dart';

import '../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  setUp(() {
    registerAllMockServices();

    stubGqlResponse<GQueryUsersInGroupData, GQueryUsersInGroupVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GQueryUsersInGroupData.fromJson({})!);
  });
}
