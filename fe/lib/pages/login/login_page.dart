import 'package:fe/pages/login/view/features/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/features/login/login.dart';
import 'package:fe/pages/login/view/features/logo/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: PlatformScaffold(
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
                  Login(),
                  Container(),
                ],
              ),
            ),
          ))),
    );
  }
}
