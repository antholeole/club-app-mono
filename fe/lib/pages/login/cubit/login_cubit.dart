import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/gql/authenticate.req.gql.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/schema.schema.gql.dart';

import '../../../service_locator.dart';

part 'login_state.dart';

enum LoginType {
  Google,
}

class LoginCubit extends Cubit<LoginState> {
  final _localUserService = getIt<LocalUserService>();
  final _tokenManager = getIt<TokenManager>();
  final _client = getIt<UnauthGqlClient>();

  final _googleSignIn = getIt<GoogleSignIn>();

  LoginCubit() : super(LoginState.initial());

  Future<void> login(LoginType loginType) async {
    emit(LoginState.loading());

    _ProviderLoginDetails providerLoginDetails;

    try {
      switch (loginType) {
        case LoginType.Google:
          providerLoginDetails = await _googleLogin();
          break;
      }
    } on _UserDeniedException catch (_) {
      emit(LoginState.failure(Failure(
          status: FailureStatus.Unknown, message: 'Login process aborted.')));
      return;
    } on Exception catch (e) {
      emit(LoginState.failure(
          Failure(status: FailureStatus.Unknown, message: e.toString())));
      return;
    }

    BackendAccessTokens backendAccessTokens;
    try {
      backendAccessTokens =
          await _getGqlAuth(loginType, providerLoginDetails.idToken);
    } on Failure catch (f) {
      emit(LoginState.failure(f));
      return;
    }

    await _tokenManager.initalizeTokens(backendAccessTokens);

    final localUser = User(
        name: providerLoginDetails.displayName ?? 'Club App User',
        id: backendAccessTokens.id);

    await _localUserService.saveChanges(localUser);

    emit(LoginState.success(localUser));
  }

  Future<BackendAccessTokens> _getGqlAuth(
      LoginType loginType, String providerIdToken) async {
    GIdentityProvider idp;
    switch (loginType) {
      case LoginType.Google:
        idp = GIdentityProvider.Google;
        break;
    }

    final resp = await _client
        .request(GAuthenticateReq((q) => q
          ..vars.id_token = providerIdToken
          ..vars.identity_provider = idp))
        .first;

    return BackendAccessTokens(
        accessToken: resp.authenticate!.accessToken,
        id: resp.authenticate!.id,
        name: resp.authenticate!.name,
        refreshToken: resp.authenticate!.refreshToken);
  }

  Future<_ProviderLoginDetails> _googleLogin() async {
    final acc = await _googleSignIn.signIn();

    if (acc == null) {
      throw _UserDeniedException();
    }

    final auth = await acc.authentication;

    return _ProviderLoginDetails(
        email: acc.email, idToken: auth.idToken!, displayName: acc.displayName);
  }
}

@immutable
class _ProviderLoginDetails {
  final String email;
  final String? displayName;
  final String idToken;

  const _ProviderLoginDetails(
      {required this.email, this.displayName, required this.idToken});
}

class _UserDeniedException extends Error {}
