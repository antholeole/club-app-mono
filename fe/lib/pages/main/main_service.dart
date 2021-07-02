import 'package:auto_route/auto_route.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();
  final TokenManager _tokenManager = getIt<TokenManager>();
  final Client _client = getIt<Client>();

  MainService();

  Future<void> logOut(BuildContext context, {String? withError}) async {
    await Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
    AutoRouter.of(context).popUntilRouteWithName(Main.name);

    if (withError != null) {
      Toaster.of(context).errorToast(
          "Sorry, you've been logged out due to an error: $withError");
    } else {
      Toaster.of(context).warningToast('Logged Out.');
    }

    await AutoRouter.of(context).popAndPush(LoginRoute());
  }

  Future<GQuerySelfGroupsPreviewData?> querySelfGroups() async {
    return await gqlReqOrThrowFailure(
        GQuerySelfGroupsPreviewReq((q) => q
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..vars.self_id = _user.uuid),
        _client);
  }

  Future<WsClient> getWsClient() async {
    String? aToken = await _tokenManager.read();
    try {
      aToken ??= await _tokenManager.refresh();
    } on TokenException catch (_) {
      throw Failure(status: FailureStatus.GQLRefresh, resolved: false);
    }
    return WsClient(aToken);
  }
}
