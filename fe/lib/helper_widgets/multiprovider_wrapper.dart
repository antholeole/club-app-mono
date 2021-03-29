import 'package:fe/data_classes/local_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiproviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiproviderWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<LocalUser>(create: (_) => LocalUser())],
      child: child,
    );
  }
}
