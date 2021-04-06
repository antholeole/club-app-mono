import 'package:fe/data_classes/backend_access_tokens.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/data_classes/provider_access_token.dart';
import 'package:fe/stdlib/clients/http_client.dart';
import 'package:fe/stdlib/helpers/tuple.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../service_locator.dart';
import 'login_exception.dart';

//962929179530-qj3o1qkjh1pdu16jcou44m88pi894d4i.apps.googleusercontent.com <- IOS
//962929179530-utmni9p2cmd2uuhvrthf7dp4kdnku1vc.apps.googleusercontent.com <- ADRIOD

class LoginService {
  final _client = getIt<HttpClient>();

  Future<void> logout() async {}

  //Returns localUser, idToken
  Future<Tuple<LocalUser, String>> login(LoginType loginType) async {
    switch (loginType) {
      case LoginType.Google:
        return _googleLogin();
    }
  }

  Future<Tuple<LocalUser, String>> _googleLogin() async {
    final _googleSignIn = GoogleSignIn(
      scopes: [],
    );

    final acc = await _googleSignIn.signIn();

    if (acc == null) {
      throw UserDeniedException();
    }

    final localUser = LocalUser.fromProviderLogin(LoginType.Google, acc.email,
        name: acc.displayName);

    final auth = await acc.authentication;

    return Tuple(item1: localUser, item2: auth.idToken!);
  }

  Future<BackendAccessTokens> getGqlAuth(ProviderIdToken providerAccess) async {
    final tokens = await _client.postReq('/auth', providerAccess.toJson());

    return BackendAccessTokens.fromJson(tokens.body);
  }
}
