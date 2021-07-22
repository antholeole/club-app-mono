import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();
  final LocalUserService _localUserService = getIt<LocalUserService>();
  final Client _client = getIt<Client>();

  MainService();

  Future<void> logOut(BuildContext context, {String? withError}) async {
    await Future.wait([_localFileStore.clear(), _secureStorage.deleteAll()]);
    AutoRouter.of(context).popUntilRouteWithName(Main.name);

    if (withError != null) {
      Toaster.of(context).errorToast(
          "Sorry, you've been logged out due to an error: $withError");
    } else {
      Toaster.of(context).warningToast('Logged Out.');
    }

    await AutoRouter.of(context).popAndPush(const LoginRoute());
  }

  Future<GQuerySelfGroupsPreviewData> querySelfGroups() async {
    final userId = await _localUserService.getLoggedInUserId();

    //try to get data from network. if it fails, get it from cache.
    try {
      return await gqlReqOrThrowFailure(
          GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.self_id = userId),
          _client);
    } on Failure catch (f) {
      if (f.status.fatal) {
        rethrow;
      }

      return await gqlReqOrThrowFailure(
          GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.CacheOnly
            ..vars.self_id = userId),
          _client);
    }
  }

  Future<User> getUser() async {
    return _localUserService.getLoggedInUser();
  }
}
