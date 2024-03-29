import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

extension AssetLocation on LoginType {
  String get imageLocation {
    switch (this) {
      case LoginType.Google:
        return 'assets/icons/identities/google_logo.png';
    }
  }
}

class SignInWithProviderButton extends StatelessWidget {
  final LoginType _loginType;

  const SignInWithProviderButton({
    required LoginType loginType,
  }) : _loginType = loginType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.read<LoginCubit>().login(_loginType),
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: _getColor(),
            padding: const EdgeInsets.all(15)),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              child: Image.asset(
                _loginType.imageLocation,
                height: 40,
              ),
            ),
            Container(
              height: 35,
              width: 2,
              color: Colors.white60,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Sign in with ${_getName()}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    switch (_loginType) {
      case LoginType.Google:
        return const Color(0xff4285F4);
    }
  }

  String _getName() {
    switch (_loginType) {
      case LoginType.Google:
        return 'Google';
    }
  }
}
