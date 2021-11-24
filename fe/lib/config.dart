abstract class Config {
  //if an animation is generally taxing in debug mode,
  //this bool can toggle it off.
  int? get hasuraPort;
  String get hasuraHost;
  List<String> get gqlPathSegments;
  bool get transportIsSecure;
  bool get refreshLocalCacheOnReload;
  bool get prod;
}

class LocalConfig extends Config {
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

  @override
  bool get prod => false;
}

class DevConfig extends Config {
  @override
  String get hasuraHost => 'dev-hasura.getclub.app';

  @override
  List<String> get gqlPathSegments => ['v1', 'graphql'];

  @override
  bool get transportIsSecure => true;

  @override
  bool get refreshLocalCacheOnReload => false;

  @override
  int? get hasuraPort => null;

  @override
  bool get prod => false;
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

  @override
  bool get prod => true;
}
