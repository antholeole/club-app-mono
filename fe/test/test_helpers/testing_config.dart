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
  List<String> get gqlPathSegments => throw UnimplementedError();

  @override
  String get hasuraHost => throw UnimplementedError();

  @override
  int? get hasuraPort => throw UnimplementedError();

  @override
  bool get transportIsSecure => throw UnimplementedError();
}
