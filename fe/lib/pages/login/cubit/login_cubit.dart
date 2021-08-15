import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/http_client/http_client.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import '../../../service_locator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _client = getIt<UnauthHttpClient>();
  final _localUserService = getIt<LocalUserService>();

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
      emit(LoginState.initial());
      return;
    } on HttpException catch (e) {
      emit(LoginState.failure(await HttpClient.basicHttpErrorHandler(e)));
      return;
    }

    final providerAccessToken =
        ProviderIdToken(from: loginType, idToken: providerLoginDetails.idToken);
    final backendAccessTokens = await _getGqlAuth(providerAccessToken);

    await TokenManager.setTokens(backendAccessTokens);

    final localUser = User(
        name: providerLoginDetails.displayName ?? 'Club App User',
        id: UuidType(backendAccessTokens.id));

    await _localUserService.saveChanges(localUser);

    emit(LoginState.success(localUser));
  }

  Future<BackendAccessTokens> _getGqlAuth(
      ProviderIdToken providerAccess) async {
    final tokens = await _client.postReq('/auth', providerAccess.toJson());

    return BackendAccessTokens.fromJson(tokens.body);
  }

  Future<_ProviderLoginDetails> _googleLogin() async {
    final _googleSignIn = GoogleSignIn(
      scopes: [],
    );

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
