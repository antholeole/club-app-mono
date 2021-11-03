abstract class Config {
  //if an animation is generally taxing in debug mode,
  //this bool can toggle it off.
  int? get hasuraPort;
  String get hasuraHost;
  List<String> get gqlPathSegments;
  bool get transportIsSecure;
  bool get refreshLocalCacheOnReload;

  //use in exclusive cases where
  //testing requires a different variable.
  //i.e. don't let bloc trigger events on constructor
  //to avoid needing to stub everything
  bool get testing;
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
  bool get testing => false;

  @override
  int? get hasuraPort => 8080;
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
  bool get testing => false;

  @override
  int? get hasuraPort => null;
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
  bool get testing => false;

  @override
  int? get hasuraPort => null;
}
