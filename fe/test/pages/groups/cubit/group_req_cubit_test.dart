import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/gql/query_self_groups.req.gql.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final UuidType userId = UuidType.generate();
  ;
  blocTest<GroupReqCubit, GQuerySelfGroupsReq>(
      'on refresh should emit new groups request',
      build: () => GroupReqCubit(userId),
      act: (cubit) => cubit.refresh(),
      expect: () => [isA<GQuerySelfGroupsReq>()]);
}
