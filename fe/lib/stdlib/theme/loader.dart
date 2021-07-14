import 'package:fe/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../service_locator.dart';

class Loader extends StatefulWidget {
  final double _size;
  final bool _white;

  Loader({double size = 32, bool white = false})
      : _size = size,
        _white = white;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _showFiller;

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
            size: widget._size,
            color:
                widget._white ? Colors.white : Theme.of(context).primaryColor,
            controller: _animationController,
          );
  }

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  void _prepareAnimations() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));

    _showFiller = !getIt<Config>().playTaxingAnimations;
  }
}
