import 'package:fe/config.dart';

class TestingConfig extends Config {
  TestingConfig();

  @override
  bool get refreshLocalCacheOnReload => true;

  @override
  List<String> get gqlPathSegments => ['asd', 'asda'];

  @override
  String get hasuraHost => 'adsa';

  @override
  int? get hasuraPort => 8000;

  @override
  bool get transportIsSecure => false;

  @override
  bool get prod => true;

  @override
  String get repr => 'testing';
}
