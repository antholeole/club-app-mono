import 'package:fe/pages/main/main_helpers/main_provider.dart';
import 'package:fe/pages/main/main_page.dart';
import 'package:flutter/cupertino.dart';

class MainPageWrapper extends StatelessWidget {
  const MainPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainProvider(
      child: MainPage(),
    );
  }
}
