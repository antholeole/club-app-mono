import 'package:fe/gql/fragments/join_token.ast.gql.dart';
import 'package:ferry/ferry.dart';

import 'join_token.data.gql.dart';

final Map<String, TypePolicy> typePolicies = {
  'group_join_tokens': TypePolicy(keyFields: {'group_id': true})
};
