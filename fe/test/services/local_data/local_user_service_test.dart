import 'dart:convert';

import 'package:fe/data/models/user.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../test_helpers/get_it_helpers.dart';

void main() {
  final fakeUser = User(name: 'padre', id: UuidType.generate());

  setUp(() async {
    await registerAllMockServices();
  });
  test('should local file store serialize user on saveChanges', () {
    when(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.LocalUser, any())).thenAnswer((_) async => null);

    final LocalUserService localUserService = LocalUserService();
    localUserService.saveChanges(fakeUser);

    verify(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.LocalUser, json.encode(fakeUser))).called(1);
  });

  group('get logged in user', () {
    test('should throw failure if not logged in', () async {
      when(() =>
              getIt<LocalFileStore>().deserialize(LocalStorageType.LocalUser))
          .thenAnswer((_) async => null);

      final LocalUserService localUserService = LocalUserService();

      expect(
          localUserService.getLoggedInUser(),
          throwsA(isA<Failure>()
              .having((f) => f.status, 'status', FailureStatus.NotLoggedIn)));
    });

    test('should return user if logged in', () async {
      when(() =>
              getIt<LocalFileStore>().deserialize(LocalStorageType.LocalUser))
          .thenAnswer((_) async => json.encode(fakeUser.toJson()));

      final LocalUserService localUserService = LocalUserService();

      expect(await localUserService.getLoggedInUser(), fakeUser);
    });
  });

  group('get logged in user id', () {
    test('should return from shared prefrences if in shared prefrences',
        () async {
      when(() => getIt<SharedPreferences>().containsKey(USER_ID_KEY))
          .thenReturn(true);
      when(() => getIt<SharedPreferences>().getString(USER_ID_KEY))
          .thenReturn(fakeUser.id.uuid);

      final LocalUserService localUserService = LocalUserService();

      expect(await localUserService.getLoggedInUserId(), fakeUser.id);
      verifyNever(() =>
          getIt<LocalFileStore>().deserialize(LocalStorageType.LocalUser));
    });

    group('not in shared pref', () {
      setUp(() {
        when(() => getIt<SharedPreferences>().containsKey(USER_ID_KEY))
            .thenReturn(false);
        when(() =>
                getIt<LocalFileStore>().deserialize(LocalStorageType.LocalUser))
            .thenAnswer((_) async => json.encode(fakeUser.toJson()));
      });

      test('should return from localFileStore', () async {
        when(() => getIt<SharedPreferences>().setString(
            USER_ID_KEY, fakeUser.id.uuid)).thenAnswer((_) async => true);

        final LocalUserService localUserService = LocalUserService();

        expect(await localUserService.getLoggedInUserId(), fakeUser.id);
        verify(() =>
                getIt<LocalFileStore>().deserialize(LocalStorageType.LocalUser))
            .called(1);
      });

      test('should store id in shared pref', () async {
        when(() => getIt<SharedPreferences>().setString(
            USER_ID_KEY, fakeUser.id.uuid)).thenAnswer((_) async => true);

        final LocalUserService localUserService = LocalUserService();

        expect(await localUserService.getLoggedInUserId(), fakeUser.id);

        verify(() => getIt<SharedPreferences>()
            .setString(USER_ID_KEY, fakeUser.id.uuid)).called(1);
      });
    });
  });

  test('should local file store serialize user on saveChanges', () {
    when(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.LocalUser, any())).thenAnswer((_) async => null);

    final LocalUserService localUserService = LocalUserService();
    localUserService.saveChanges(fakeUser);

    verify(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.LocalUser, json.encode(fakeUser.toJson()))).called(1);
  });
}
