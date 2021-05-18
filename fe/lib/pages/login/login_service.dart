import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/stdlib/clients/http/unauth_http_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/token_manager.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../service_locator.dart';
import 'login_exception.dart';

//962929179530-qj3o1qkjh1pdu16jcou44m88pi894d4i.apps.googleusercontent.com <- IOS
//962929179530-utmni9p2cmd2uuhvrthf7dp4kdnku1vc.apps.googleusercontent.com <- ADRIOD

class LoginService {
  final _client = getIt<UnauthHttpClient>();
  final _localUser = getIt<LocalUser>();

  LoginService();

  Future<void> login(LoginType loginType) async {
    _ProviderLoginDetails providerLoginDetails;
    switch (loginType) {
      case LoginType.Google:
        providerLoginDetails = await _googleLogin();
        break;
    }

    final providerAccessToken =
        ProviderIdToken(from: loginType, idToken: providerLoginDetails.idToken);
    final backendAccessTokens = await _getGqlAuth(providerAccessToken);

    await TokenManager.setTokens(backendAccessTokens);

    final localUser = LocalUser(
        name: providerLoginDetails.displayName,
        email: providerLoginDetails.email,
        uuid: UuidType(backendAccessTokens.id));

    _localUser.login(localUser);

    await localUser.serializeSelf();
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
      throw UserDeniedException();
    }

    final auth = await acc.authentication;

    return _ProviderLoginDetails(
        email: acc.email, idToken: auth.idToken!, displayName: acc.displayName);
  }
}

//helper class
class _ProviderLoginDetails {
  final String email;
  final String? displayName;
  final String idToken;

  const _ProviderLoginDetails(
      {required this.email, this.displayName, required this.idToken});
}
