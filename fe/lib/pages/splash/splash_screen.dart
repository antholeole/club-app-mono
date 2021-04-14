import 'package:auto_route/auto_route.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/pages/login/widgets/sign_in_with_provider_button.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class SplashScreen extends StatefulWidget {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();

  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _beginLoadingImagesFromLoginPage();
  }

  @override
  void initState() {
    _beginLoadingFromMemory();
    super.initState();
  }

  //so we don't have ugly asset loads infront of the user
  Future<void> _beginLoadingFromMemory() async {
    final localUserString =
        await widget._localFileStore.deserialize(LocalStorageType.LocalUser);
    if (localUserString == null) {
      await AutoRouter.of(context).popAndPush(LoginRoute());
    } else {
      getIt<LocalUser>().fromUser(LocalUser.fromJson(localUserString));
      await AutoRouter.of(context).popAndPush(Main());
    }
  }

  Future<void> _beginLoadingImagesFromLoginPage() async {
    List<Future<dynamic>> futures = [];

    for (final provider in LoginType.values) {
      futures.add(precacheImage(AssetImage(provider.imageLocation), context));
    }

    await Future.wait(futures);
  }
}
