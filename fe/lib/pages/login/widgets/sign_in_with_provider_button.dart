import 'package:fe/data_classes/local_user.dart';
import 'package:flutter/material.dart';

class SignInWithProviderButton extends StatelessWidget {
  final void Function() _onClick;
  final LoginType _loginType;

  const SignInWithProviderButton({
    required void Function() onClick,
    required LoginType loginType,
  })   : _loginType = loginType,
        _onClick = onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: _onClick,
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: _getColor(),
            padding: EdgeInsets.all(15)),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
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
        return Color(0xff4285F4);
    }
  }

  String _getName() {
    switch (_loginType) {
      case LoginType.Google:
        return 'Google';
    }
  }
}

extension AssetLocation on LoginType {
  String get imageLocation {
    return ['assets/icons/identities/google_logo.png'][index];
  }
}
