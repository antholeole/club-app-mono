import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();
  final TokenManager _tokenManager = getIt<TokenManager>();
  final Client _client = getIt<Client>();

  MainService();

  Future<void> logOut() {
    return Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }

  Future<GQuerySelfGroupsPreviewData?> querySelfGroups() async {
    final req = GQuerySelfGroupsPreviewReq((q) => q
      ..fetchPolicy = FetchPolicy.NetworkOnly
      ..vars.self_id = _user.uuid);

    final resp = await _client.request(req).first;

    if (resp.hasErrors) {
      final f = await basicGqlErrorHandler(resp);
      throw f;
    }

    return resp.data;
  }

  Future<WsClient> getWsClient() async {
    String? aToken = await _tokenManager.read();
    try {
      aToken ??= await _tokenManager.refresh();
    } on TokenException catch (_) {
      throw Failure(
          status: FailureStatus.GQLRefresh,
          message: 'failed to refresh token',
          resolved: false);
    }
    return WsClient(aToken);
  }
}
