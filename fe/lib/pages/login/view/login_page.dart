import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/widgets/sign_in_with_provider_button.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flow_builder/flow_builder.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(
                  filled: true,
                ),
                BlocConsumer<LoginCubit, LoginState>(
                    builder: (context, state) => state.join(
                        (_) => _buildInitLoginButtons(),
                        (_) => const Loader(),
                        (_) => const Text('logging in...'),
                        (_) => _buildInitLoginButtons()),
                    listener: (context, state) => state.join(
                        (_) => null,
                        (_) => null,
                        (success) => context
                            .flow<AppState>()
                            .update((_) => AppState.loggedIn(success.user)),
                        (error) => error.failure != null
                            ? handleFailure(error.failure!, context,
                                withPrefix: 'Error logging in')
                            : null)),
                Container(),
              ],
            ),
          ),
        )));
  }

  Widget _buildInitLoginButtons() {
    return Column(
        children: LoginType.values
            .map((loginType) => SignInWithProviderButton(loginType: loginType))
            .toList());
  }
}
