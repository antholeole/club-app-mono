import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_gql_error.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../service_locator.dart';

enum MainPageState { Loading, NoGroups, WithGroups, Error }

class MainPageInitalLoadCarrier {
  final MainPageState state;
  final Failure? failure;
  final Group? group;

  const MainPageInitalLoadCarrier(
      {this.group, required this.state, this.failure})
      : assert((failure != null && state == MainPageState.Error) ||
            (group != null && state == MainPageState.WithGroups) ||
            (group == null && state == MainPageState.NoGroups)),
        assert(state != MainPageState.Loading);
}

class MainService {
  final LocalUser _user = getIt<LocalUser>();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final FlutterSecureStorage _secureStorage = getIt<FlutterSecureStorage>();
  final Client _client = getIt<Client>();

  MainService();

  Future<void> logOut() {
    return Future.wait(
        [_localFileStore.clear(), _user.logOut(), _secureStorage.deleteAll()]);
  }

  Future<MainPageInitalLoadCarrier> initalLoad() async {
    final req = GQuerySelfGroupsPreviewReq((q) => q
      ..fetchPolicy = FetchPolicy.NetworkOnly
      ..vars.self_id = _user.uuid);

    final resp = await _client.request(req).first;

    if (resp.hasErrors) {
      final f = await basicGqlErrorHandler(resp);
      return MainPageInitalLoadCarrier(state: MainPageState.Error, failure: f);
    }

    if (resp.data!.user_to_group.isEmpty) {
      return MainPageInitalLoadCarrier(
        state: MainPageState.NoGroups,
      );
    } else {
      return MainPageInitalLoadCarrier(
          state: MainPageState.WithGroups,
          group: Group(
              id: resp.data!.user_to_group[0].group.id,
              name: resp.data!.user_to_group[0].group.group_name,
              admin: resp.data!.user_to_group[0].admin));
    }
  }
}
