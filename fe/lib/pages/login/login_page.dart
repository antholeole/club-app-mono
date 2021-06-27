import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/login/widgets/sign_in_with_provider_button.dart';
import 'package:fe/stdlib/clients/http_client/http_client.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../service_locator.dart';
import 'login_exception.dart';
import 'login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginService _loginService = getIt<LoginService>();
  late BuildContext _toastableContext;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (toastableContext) {
      _toastableContext = toastableContext;
      return PlatformScaffold(
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
    });
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

    try {
      await _loginService.login(loginType);
      await _proceedToApp();
    } on UserDeniedException catch (_) {} on HttpException catch (e) {
      final f = await HttpClient.basicHttpErrorHandler(e, {});
      Toaster.of(_toastableContext).errorToast(f.status.message);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _proceedToApp() async {
    await AutoRouter.of(context).navigate(Main());
  }
}
