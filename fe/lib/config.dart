abstract class Config {
  //if an animation is generally taxing in debug mode,
  //this bool can toggle it off.
  bool get playTaxingAnimations;
  String get connectionUrl;
  bool get httpIsSecure;
  String get gqlUrl;
}

class ProdConfig extends Config {
  @override
  bool get playTaxingAnimations => true;

  @override
  String get connectionUrl => throw UnimplementedError('bruh');

  @override
  bool get httpIsSecure => true;

  @override
  String get gqlUrl => throw UnimplementedError('bruh');
}

class DevConfig extends Config {
  @override
  bool get playTaxingAnimations => false;

  @override
  String get connectionUrl => '127.0.0.1:8787';

  @override
  bool get httpIsSecure => false;

  @override
  String get gqlUrl => 'http://127.0.0.1:8080/v1/graphql';
}
