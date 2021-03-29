import 'package:fe/constants.dart';
import 'package:fe/data_classes/backend_access_tokens.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/data_classes/provider_access_token.dart';
import 'package:fe/helpers/DEBUG_print.dart';
import 'package:fe/conn_clients/http_client.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../service_locator.dart';
import 'login_exception.dart';

//962929179530-qj3o1qkjh1pdu16jcou44m88pi894d4i.apps.googleusercontent.com <- IOS
//962929179530-utmni9p2cmd2uuhvrthf7dp4kdnku1vc.apps.googleusercontent.com <- ADRIOD

class LoginService {
  final _client = getIt<HttpClient>();

  Future<void> logout() async {}

  //Returns idToken
  Future<String> login(LoginType loginType, LocalUser user) async {
    switch (loginType) {
      case LoginType.Google:
        return _googleLogin(user);
    }
  }

  Future<String> _googleLogin(LocalUser user) async {
    final _googleSignIn = GoogleSignIn(
      scopes: [],
    );

    final acc = await _googleSignIn.signIn();

    if (acc == null) {
      throw UserDeniedException();
    }

    user.providerLogin(
      LoginType.Google,
      acc.displayName ?? DEFAULT_USERNAME,
      acc.email,
    );

    final auth = await acc.authentication;

    return auth.idToken!;
  }

  Future<BackendAccessTokens> getGqlAuth(ProviderIdToken providerAccess) async {
    final tokens = await _client.postReq('/auth', providerAccess.toJson());

    return BackendAccessTokens.fromJson(tokens.body);
  }
}
