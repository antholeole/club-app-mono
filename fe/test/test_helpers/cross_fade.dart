import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Type crossFadeShows({Finder? finder}) {
  final AnimatedCrossFade crossFade = (finder ?? find.byType(AnimatedCrossFade))
      .first
      .evaluate()
      .first
      .widget as AnimatedCrossFade;

  switch (crossFade.crossFadeState) {
    case CrossFadeState.showFirst:
      return crossFade.firstChild.runtimeType;
    case CrossFadeState.showSecond:
      return crossFade.secondChild.runtimeType;
  }
}
