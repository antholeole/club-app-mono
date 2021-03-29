import 'package:auto_route/auto_route.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/data_classes/provider_access_token.dart';
import 'package:fe/helper_widgets/router.gr.dart';
import 'package:fe/pages/login/widgets/sign_in_with_provider_button.dart';
import 'package:fe/theme/loader.dart';
import 'package:fe/theme/logo.dart';
import 'package:flutter/material.dart';

import 'login_exception.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginService _loginService = LoginService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    filled: true,
                  ),
                  loading ? Loader() : _buildInitLoginButton(),
                  Container(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildInitLoginButton() {
    return Column(
      children: [
        SignInWithProviderButton(
            loginType: LoginType.Google,
            onClick: () => _initLogin(context, LoginType.Google)),
      ],
    );
  }

  Future<void> _initLogin(BuildContext context, LoginType loginType) async {
    setState(() {
      loading = true;
    });

    final localUser = LocalUser();

    try {
      final aToken = await _loginService.login(loginType, localUser);
      final providerAccessToken = ProviderIdToken(
          from: loginType,
          idToken: aToken,
          name: localUser.name,
          email: localUser.email);
      final t = await _loginService.getGqlAuth(providerAccessToken);
      await localUser.backendLogin(t);
      await localUser.serializeSelf();
      await _proceedToApp(localUser);
    } on UserDeniedException catch (_) {} finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _proceedToApp(LocalUser localUser) async {
    await AutoRouter.of(context).popAndPush(MainWrapperRoute(user: localUser));
  }
}
