import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.req.gql.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../service_locator.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final _gqlClient = getIt<AuthGqlClient>();
  final _localUserService = getIt<LocalUserService>();
  final _localFileStore = getIt<LocalFileStore>();
  final _secureStorage = getIt<FlutterSecureStorage>();
  final _tokenManager = getIt<TokenManager>();

  MainCubit() : super(MainState.loading()) {
    initalizeMainPage();
  }

  Future<void> initalizeMainPage() async {
    try {
      final data = await _querySelfGroups();
      emit(_determineStateFromData(data));
    } on Failure catch (f) {
      emit(MainState.loadFailure(f));
    }
  }

  void setClub(Club group) {
    emit(MainState.withClub(group));
  }

  void setDm(Dm dm) {
    emit(MainState.withDm(dm: dm));
  }

  Future<void> logOut({String? withError}) async {
    await Future.wait([
      _localFileStore.delete(LocalStorageType.LocalUser),
      _secureStorage.deleteAll(),
      _tokenManager.delete(),
    ]);
    Sentry.configureScope((scope) => scope.user = null);
    emit(MainState.logOut(withError: withError));
  }

  MainState _determineStateFromData(GQuerySelfGroupsPreviewData data) {
    if (data.user_to_group.isEmpty) {
      return MainState.groupless();
    } else {
      final group = Club(
          id: data.user_to_group[0].group!.id,
          name: data.user_to_group[0].group!.name,
          admin: data.user_to_group[0].owner ?? false);

      return MainState.withClub(group);
    }
  }

  Future<GQuerySelfGroupsPreviewData> _querySelfGroups() async {
    final userId = await _localUserService.getLoggedInUserId();

    //try to get data from network. if it fails, get it from cache.
    try {
      return await _gqlClient
          .request(GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.self_id = userId))
          .first;
    } on Failure catch (f) {
      if (f.status.fatal) {
        rethrow;
      }

      return await _gqlClient
          .request(GQuerySelfGroupsPreviewReq((q) => q
            ..fetchPolicy = FetchPolicy.CacheOnly
            ..vars.self_id = userId))
          .first;
    }
  }
}
