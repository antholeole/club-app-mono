abstract class Config {
  int? get hasuraPort;
  String get hasuraHost;
  List<String> get gqlPathSegments;
  bool get transportIsSecure;
  bool get refreshLocalCacheOnReload;
  bool get prod;

  String get bucketBaseUrl;

  String get sentryUrl =>
      'https://7f657ba305c143df8671d07a863e2265@o929930.ingest.sentry.io/6117405';
  String get repr;
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

  @override
  String get repr => 'local';

  @override
  String get bucketBaseUrl => throw UnimplementedError();
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

  @override
  String get repr => 'dev';

  @override
  String get bucketBaseUrl => throw UnimplementedError();
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

  @override
  String get repr => 'prod';

  @override
  String get bucketBaseUrl => throw UnimplementedError();
}
