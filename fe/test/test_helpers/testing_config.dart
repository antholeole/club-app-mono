import 'package:fe/config.dart';

class TestingConfig extends Config {
  final bool _needAutoEvents;

  TestingConfig({bool needAutoEvents = false})
      : _needAutoEvents = needAutoEvents;

  @override
  bool get playTaxingAnimations => true;

  @override
  bool get refreshLocalCacheOnReload => true;

  @override
  bool get testing => !_needAutoEvents;

  @override
  List<String> get gqlPathSegments => ['asd', 'asda'];

  @override
  String get hasuraHost => 'adsa';

  @override
  int? get hasuraPort => 8000;

  @override
  bool get transportIsSecure => false;
}
