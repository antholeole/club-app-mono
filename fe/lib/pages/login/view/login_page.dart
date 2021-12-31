import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/cubit/login_state.dart';
import 'package:fe/pages/login/view/widgets/sign_in_with_provider_button.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flow_builder/flow_builder.dart';

import '../../../service_locator.dart';

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
  final _handler = getIt<Handler>();

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
                    builder: (context, state) => state.when(
                        initial: () => _buildInitLoginButtons(),
                        loading: () => const Loader(),
                        success: (_) => const Text('logging in...'),
                        failure: (_) => _buildInitLoginButtons()),
                    listener: (context, state) => state.maybeWhen(
                        orElse: () => null,
                        success: (user) => context
                            .flow<AppState>()
                            .update((_) => AppState.loggedIn(user)),
                        failure: (f) => _handler.handleFailure(f, context,
                            withPrefix: 'Error logging in'))),
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
