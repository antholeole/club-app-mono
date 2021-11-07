import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/splash/cubit/splash_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/image_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/fixtures/user.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/get_it_helpers.dart';

void main() {
  group('SplashCubit', () {
    late MockLocalFileStore mockLocalFileStore;
    late MockImageHandler mockImageHandler;
    late MockSharedPreferences mockSharedPreferences;

    setUpAll(() {
      mockLocalFileStore = MockLocalFileStore.getMock();
      mockImageHandler = MockImageHandler.getMock();
      mockSharedPreferences = MockSharedPreferences();

      registerAllMockServices();

      getIt.registerSingleton<LocalFileStore>(mockLocalFileStore);
      getIt.registerSingleton<ImageHandler>(mockImageHandler);
      getIt.registerSingletonAsync<SharedPreferences>(
          () async => mockSharedPreferences);
    });

    setUp(() {
      reset(mockLocalFileStore);
      reset(mockImageHandler);

      when(() => mockImageHandler.preCache(any()))
          .thenAnswer((invocation) async => null);
      when(() => mockLocalFileStore.deserialize(any()))
          .thenAnswer((invocation) async => null);
    });

    blocTest<SplashCubit, SplashState>('begins load of images',
        setUp: () => when(() =>
                mockLocalFileStore.deserialize(LocalStorageType.LocalUser))
            .thenAnswer((_) async => null),
        build: () => SplashCubit(),
        act: (cubit) => cubit.beginLoads(),
        verify: (_) => verify(() => mockImageHandler.preCache(any())));

    blocTest<SplashCubit, SplashState>(
      'emits main page when no user is deserialized',
      setUp: () =>
          when(() => mockLocalFileStore.deserialize(LocalStorageType.LocalUser))
              .thenAnswer((_) async => null),
      build: () => SplashCubit(),
      act: (cubit) => cubit.beginLoads(),
      expect: () => [SplashState.notLoggedIn()],
    );

    blocTest<SplashCubit, SplashState>(
      'emits login page when user is deserialized',
      setUp: () =>
          when(() => mockLocalFileStore.deserialize(LocalStorageType.LocalUser))
              .thenAnswer((_) async => json.encode(mockUser.toJson())),
      build: () => SplashCubit(),
      act: (cubit) => cubit.beginLoads(),
      expect: () => [SplashState.loggedIn(mockUser)],
    );
  });
}
