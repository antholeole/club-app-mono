import 'package:fe/config.dart';

class TestingConfig extends Config {
  @override
  String get connectionUrl => 'not_real';

  @override
  String get gqlUrl => 'not_real_gql';

  @override
  bool get httpIsSecure => false;

  @override
  bool get playTaxingAnimations => true;

  @override
  bool get refreshLocalCacheOnReload => true;

  @override
  bool get memoryCache => true;
}
