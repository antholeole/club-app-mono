import 'package:fe/constants.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/refresh.data.gql.dart';
import 'package:fe/gql/refresh.var.gql.dart';

import '../../test_helpers/get_it_helpers.dart';
import '../../test_helpers/stub_gql_response.dart';

void main() {
  const rToken = 'adasd';
  const aToken = 'adsdasdasda longer';

  setUp(() async {
    await registerAllMockServices();
  });

  group('set tokens', () {
    test('should write tokens to local file store', () async {
      when(() => getIt<FlutterSecureStorage>().write(
          key: REFRESH_TOKEN_KEY, value: rToken)).thenAnswer((_) async => null);
      when(() => getIt<LocalFileStore>().serialize(
          LocalStorageType.AccessTokens, aToken)).thenAnswer((_) async => null);

      final tokenManager = TokenManager();

      await tokenManager.initalizeTokens(BackendAccessTokens(
          accessToken: aToken,
          refreshToken: rToken,
          name: 'd',
          id: UuidType.generate()));

      verify(() => getIt<LocalFileStore>()
          .serialize(LocalStorageType.AccessTokens, aToken)).called(1);
      verify(() => getIt<FlutterSecureStorage>()
          .write(key: REFRESH_TOKEN_KEY, value: rToken)).called(1);
    });
  });

  group('delete', () {
    test('should delete tokens', () async {
      when(() => getIt<FlutterSecureStorage>().delete(key: REFRESH_TOKEN_KEY))
          .thenAnswer((_) async => null);
      when(() => getIt<LocalFileStore>().delete(LocalStorageType.AccessTokens))
          .thenAnswer((_) async => null);

      final tokenManager = TokenManager();
      await tokenManager.delete();

      verify(() =>
              getIt<LocalFileStore>().delete(LocalStorageType.AccessTokens))
          .called(1);
      verify(() => getIt<FlutterSecureStorage>().delete(key: REFRESH_TOKEN_KEY))
          .called(1);
    });
  });

  group('read', () {
    test('should read from disk when tokens not cached', () async {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.AccessTokens))
          .thenAnswer((_) async => aToken);

      final tokenManager = TokenManager();
      await tokenManager.read();

      verify(() => getIt<LocalFileStore>()
          .deserialize(LocalStorageType.AccessTokens)).called(1);
    });

    test('should read accessToken from memory cache where have tokens',
        () async {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.AccessTokens))
          .thenAnswer((_) async => aToken);

      final tokenManager = TokenManager();
      await tokenManager.read();
      await tokenManager.read();

      verify(() => getIt<LocalFileStore>()
          .deserialize(LocalStorageType.AccessTokens)).called(1);
    });
  });

  group('refresh', () {
    final userId = UuidType.generate();

    setUp(() {
      when(() => getIt<LocalUserService>().getLoggedInUserId())
          .thenAnswer((_) async => userId);
    });

    test('should write and return access token on successful refresh',
        () async {
      when(() => getIt<FlutterSecureStorage>().read(key: REFRESH_TOKEN_KEY))
          .thenAnswer((_) async => rToken);

      stubGqlResponse<GRefreshData, GRefreshVars>(
        getIt<UnauthGqlClient>(),
        data: (_) => GRefreshData.fromJson({
          'refreshAccessToken': {'accessToken': aToken}
        })!,
      );

      when(() => getIt<LocalFileStore>().serialize(
          LocalStorageType.AccessTokens, aToken)).thenAnswer((_) async => null);

      final tokenManager = TokenManager();
      expect(await tokenManager.refresh(), aToken);

      verify(() => getIt<LocalFileStore>()
          .serialize(LocalStorageType.AccessTokens, aToken)).called(1);
    });

    test('should throw Refresh Failure on unsuccessful refresh', () async {
      when(() => getIt<FlutterSecureStorage>().read(key: REFRESH_TOKEN_KEY))
          .thenAnswer((_) async => rToken);

      stubGqlResponse<GRefreshData, GRefreshVars>(getIt<UnauthGqlClient>(),
          error: (_) => Failure(status: FailureStatus.GQLMisc));

      final tokenManager = TokenManager();

      expect(() async => await tokenManager.refresh(),
          throwsA(Failure(status: FailureStatus.RefreshFail)));
    });
  });
}
