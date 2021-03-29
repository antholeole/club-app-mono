import 'package:fe/data_classes/local_user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fe/data_classes/user.dart';
import 'package:fe/helper_widgets/router.gr.dart';
import 'package:fe/local_data/local_file_store.dart';
import 'package:fe/theme/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final LocalFileStore _localFileStore = LocalFileStore();

  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _beginLoadingFromMemory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Logo(
          filled: true,
        ),
      ),
    );
  }

  Future<void> _beginLoadingFromMemory() async {
    final localUserString =
        await widget._localFileStore.deserialize(LocalStorageType.LocalUser);
    if (localUserString == null) {
      await AutoRouter.of(context).popAndPush(LoginPageRoute());
    } else {
      await AutoRouter.of(context).popAndPush(MainWrapperRoute(
          user: LocalUser.fromUser(User.fromJson(localUserString))));
    }
  }
}
