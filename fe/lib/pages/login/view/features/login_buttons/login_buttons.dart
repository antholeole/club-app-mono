import 'package:fe/pages/login/view/features/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/features/login_buttons/widgets/sign_in_with_provider_button.dart';
import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: LoginType.values
            .map((loginType) => SignInWithProviderButton(loginType: loginType))
            .toList());
  }
}
