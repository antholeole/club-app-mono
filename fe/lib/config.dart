abstract class Config {
  //if an animation is generally taxing in debug mode,
  //this bool can toggle it off.
  int? get hasuraPort;
  String get hasuraHost;
  List<String> get gqlPathSegments;
  bool get transportIsSecure;
  bool get refreshLocalCacheOnReload;
}

class DevConfig extends Config {
  @override
  String get hasuraHost => 'localhost';

  @override
  List<String> get gqlPathSegments => ['v1', 'graphql'];

  @override
  bool get transportIsSecure => false;

  @override
  bool get refreshLocalCacheOnReload => false;

  @override
  int? get hasuraPort => 8080;
}

class ProdConfig extends Config {
  @override
  String get hasuraHost => throw UnimplementedError();

  @override
  List<String> get gqlPathSegments => ['v1', 'graphql'];

  @override
  bool get transportIsSecure => true;

  @override
  bool get refreshLocalCacheOnReload => false;

  @override
  int? get hasuraPort => null;
}
