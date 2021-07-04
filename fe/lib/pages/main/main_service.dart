import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class InitalLoadCarrier {
  final User localUser;
  final WsClient wsClient;
  final GQuerySelfGroupsPreviewData selfGroupsPreviewData;

  const InitalLoadCarrier(
      this.localUser, this.wsClient, this.selfGroupsPreviewData);
}

class MainService {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();
  final TokenManager _tokenManager = getIt<TokenManager>();
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

    await AutoRouter.of(context).popAndPush(LoginRoute());
  }

  Future<GQuerySelfGroupsPreviewData> querySelfGroups() async {
    final userId = await _localUserService.getLoggedInUserId();

    return await gqlReqOrThrowFailure(
        GQuerySelfGroupsPreviewReq((q) => q
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..vars.self_id = userId),
        _client);
  }

  Future<InitalLoadCarrier> initalLoad() async {
    late WsClient client;
    late GQuerySelfGroupsPreviewData groupsData;
    late User loggedInUser;

    await Future.wait([
      querySelfGroups().then((value) => groupsData = value),
      () async {
        String? aToken = await _tokenManager.read();
        aToken ??= await _tokenManager.refresh();
        return WsClient(aToken);
      }()
          .then((value) => client = value),
      _localUserService.getLoggedInUser().then((value) => loggedInUser = value)
    ]);

    return InitalLoadCarrier(loggedInUser, client, groupsData);
  }
}
