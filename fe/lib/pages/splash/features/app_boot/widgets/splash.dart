import 'package:fe/pages/login/view/features/logo/logo.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Center(
          child: Logo(
            filled: true,
          ),
        ));
  }
}
