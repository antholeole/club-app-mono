import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/gql_req_or_throw_failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/errors/failure_status.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final _gqlClient = getIt<Client>();
  final _localUserService = getIt<LocalUserService>();
  final _localFileStore = getIt<LocalFileStore>();
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _tokenManager = getIt<TokenManager>();
  final _config = getIt<Config>();

  MainCubit() : super(MainState.loading()) {
    if (!_config.testing) initalizeMainPage();
  }

  Future<void> initalizeMainPage() async {
    try {
      final loadState = await _querySelfGroups();
      emit(_determineStateFromData(loadState));
    } on Failure catch (f) {
      emit(MainState.loadFailure(f));
    }
  }

  void setGroup(Group group) {
    emit(MainState.withGroup(group));
  }

  Future<void> logOut({String? withError}) async {
    await Future.wait([
      _localFileStore.clear(),
      _secureStorage.deleteAll(),
      _tokenManager.delete()
    ]);
    emit(MainState.logOut(withError: withError));
  }

  MainState _determineStateFromData(GQuerySelfGroupsPreviewData data) {
    if (data.user_to_group.isEmpty) {
      return MainState.groupless();
    } else {
      final group = Group(
          id: data.user_to_group[0].group.id,
          name: data.user_to_group[0].group.group_name,
          admin: data.user_to_group[0].admin);

      return MainState.withGroup(group);
    }
  }

  Future<GQuerySelfGroupsPreviewData> _querySelfGroups() async {
    final userId = await _localUserService.getLoggedInUserId();

    //try to get data from network. if it fails, get it from cache.
    try {
      return await gqlReqOrThrowFailure(
          GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.self_id = userId),
          _gqlClient);
    } on Failure catch (f) {
      if (f.status.fatal) {
        rethrow;
      }

      return await gqlReqOrThrowFailure(
          GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.CacheOnly
            ..vars.self_id = userId),
          _gqlClient);
    }
  }
}
