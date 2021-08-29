import 'package:fe/config.dart';

class TestingConfig extends Config {
  final bool _needAutoEvents;

  TestingConfig({bool needAutoEvents = false})
      : _needAutoEvents = needAutoEvents;

  @override
  String get gqlUrl => 'not_real_gql';

  @override
  bool get httpIsSecure => false;

  @override
  bool get playTaxingAnimations => true;

  @override
  bool get refreshLocalCacheOnReload => true;

  @override
  String get wsUrl => 'ws://localhost:8175';

  @override
  bool get testing => !_needAutoEvents;

  @override
  String get hasuraUrl => 'unreal';
}
