import 'package:bloc/bloc.dart';
import 'package:fe/gql/query_self_groups.req.gql.dart';
import 'package:fe/stdlib/helpers/random_string.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';

class GroupReqCubit extends Cubit<GQuerySelfGroupsReq> {
  final UuidType _userId;

  GroupReqCubit(UuidType userId)
      : _userId = userId,
        super(_buildGroupReq(userId));

  void refresh() {
    emit(_buildGroupReq(_userId));
  }

  static GQuerySelfGroupsReq _buildGroupReq(UuidType userId) {
    return GQuerySelfGroupsReq(
      (b) => b
        ..requestId = generateRandomString(10)
        ..vars.selfId = userId
        ..fetchPolicy = FetchPolicy.CacheAndNetwork,
    );
  }
}
