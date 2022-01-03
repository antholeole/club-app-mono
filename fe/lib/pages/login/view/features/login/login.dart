import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/view/features/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/features/login/cubit/login_state.dart';
import 'package:fe/pages/login/view/features/login_buttons/login_buttons.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';

class Login extends StatelessWidget {
  final _handler = getIt<Handler>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) => state.when(
            initial: () => const LoginButtons(),
            loading: () => const Loader(),
            success: (_) => const Text('logging in...'),
            failure: (_) => const LoginButtons()),
        listener: (context, state) => state.maybeWhen(
            orElse: () => null,
            success: (user) =>
                context.flow<AppState>().update((_) => AppState.loggedIn(user)),
            failure: (f) => _handler.handleFailure(f, context,
                withPrefix: 'Error logging in')));
  }
}
