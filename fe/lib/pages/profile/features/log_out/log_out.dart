import 'package:fe/services/fn_providers/log_outer.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LogOut extends StatelessWidget {
  static const LOGOUT_COPY = 'Log Out';

  const LogOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: context.read<LogOuter>().logOut,
        title: const Text(
          LOGOUT_COPY,
          style: TextStyle(color: Colors.red),
        ));
  }
}
