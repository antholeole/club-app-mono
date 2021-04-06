import 'package:fe/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../service_locator.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _showFiller;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));

    _showFiller = !getIt<Config>().playTaxingAnimations;

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return _showFiller
        ? Center(
            child: CupertinoActivityIndicator(
              animating: false,
              radius: 50,
            ),
          )
        : SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            controller: _animationController,
          );
  }
}
