abstract class Config {
  //if an animation is generally taxing in debug mode,
  //this bool can toggle it off.
  String get connectionUrl;
  String get gqlUrl;
  String get wsUrl;
  bool get httpIsSecure;
  bool get playTaxingAnimations;
  bool get refreshLocalCacheOnReload;
  bool get memoryCache;

  //use in exclusive cases where
  //testing requires a different variable.
  //i.e. don't let bloc trigger events on constructor
  //to avoid needing to stub everything
  bool get testing;
}

class DevConfig extends Config {
  @override
  String get connectionUrl => '127.0.0.1:8787';

  @override
  String get gqlUrl => 'http://127.0.0.1:8080/v1/graphql';

  @override
  String get wsUrl => 'ws://127.0.0.1:5000';

  @override
  bool get httpIsSecure => false;

  @override
  bool get playTaxingAnimations => true;

  @override
  bool get refreshLocalCacheOnReload => false;

  @override
  bool get memoryCache => false;

  @override
  bool get testing => false;
}

class ProdConfig extends Config {
  @override
  String get connectionUrl => throw UnimplementedError('bruh');

  @override
  String get gqlUrl => throw UnimplementedError('bruh');

  @override
  String get wsUrl => throw UnimplementedError('bruh');

  @override
  bool get httpIsSecure => true;

  @override
  bool get playTaxingAnimations => true;

  @override
  bool get refreshLocalCacheOnReload => false;

  @override
  bool get memoryCache => false;

  @override
  bool get testing => false;
}
