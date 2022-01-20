import 'dart:convert';

import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/helpers/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/get_it_helpers.dart';

void main() {
  Map<String, dynamic> getCapturedMap([int nth = 0]) {
    return json.decode(verify(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.Notifications, captureAny())).captured[nth]);
  }

  setUpAll(() {
    registerAllMockServices();
  });

  group('constructor', () {
    test('should deserialize input json', () async {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode({
                'testFlat': 1,
                'testNested': {
                  'multipleKeys': 2,
                  'nestedVal': {'otherNested': 3}
                }
              }));

      final container = await NotificationContainer.getNotificationContainer();

      expect(
          container.get(
              const CustomNotificationPath(strings: ['invalidField', 'blah']),
              5),
          5);

      expect(
          container.get(
              const CustomNotificationPath(strings: ['testFlat']), -1),
          1);

      expect(
          container.get(
              const CustomNotificationPath(
                  strings: ['testNested', 'multipleKeys']),
              -1),
          2);

      expect(
          container.get(
              const CustomNotificationPath(
                  strings: ['testNested', 'nestedVal', 'otherNested']),
              -1),
          3);
    });
  });

  group('set', () {
    setUp(() {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode({}));
      when(() => getIt<LocalFileStore>().serialize(
          LocalStorageType.Notifications, any())).thenAnswer((_) async => null);
    });

    group('should set at path', () {
      test('flat', () async {
        final container =
            await NotificationContainer.getNotificationContainer();
        await container.set(
            const CustomNotificationPath(strings: ['testFlat']), 1);

        expect(
            const DeepCollectionEquality()
                .equals(getCapturedMap(), {'testFlat': 1}),
            true);
      });

      test('nested', () async {
        final container =
            await NotificationContainer.getNotificationContainer();
        await container.set(
            const CustomNotificationPath(strings: ['test', 'nested', 'stuff']),
            1);

        expect(
            const DeepCollectionEquality().equals(getCapturedMap(), {
              'test': {
                'nested': {'stuff': 1}
              }
            }),
            true);
      });

      test('multipleKeys', () async {
        final container =
            await NotificationContainer.getNotificationContainer();
        await container.set(
            const CustomNotificationPath(strings: ['testFlatAgain']), 1);
        await container.set(
            const CustomNotificationPath(strings: ['testFlat']), 1);

        expect(
            mapEquals(getCapturedMap(1), {'testFlat': 1, 'testFlatAgain': 1}),
            true);
      });
    });

    test('should throw if set at already written path', () async {
      final container = await NotificationContainer.getNotificationContainer();
      await container.set(
          const CustomNotificationPath(strings: ['blah', 'nested']), 1);
      expect(
          () async => await container.set(
              const CustomNotificationPath(strings: ['blah']), 1),
          throwsA(isA<IncorrectEitherMapTypeTraversal>()));
    });

    test('should notify listeners', () async {
      final container = await NotificationContainer.getNotificationContainer();

      bool listenerTrigged = false;
      container.addListener(() {
        listenerTrigged = true;
      });

      await container.set(
          const CustomNotificationPath(strings: ['blah', 'nested']), 1);

      expect(listenerTrigged, true,
          reason: 'listener should have flipped bool');
    });
  });

  group('get', () {
    final fakeMap = {
      'testFlat': 1,
      'testNested': {
        'multipleKeys': 2,
        'nestedVal': {'otherNested': 3}
      }
    };

    setUp(() {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode(fakeMap));
    });

    test('should return map', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gottenMap = container.get<Map<String, dynamic>>(
          const CustomNotificationPath(strings: ['testNested']), {});

      expect(
          const DeepCollectionEquality()
              .equals(gottenMap, fakeMap['testNested']),
          true);
    });

    test('should return int', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gottenMap = container.get<int>(
          const CustomNotificationPath(strings: ['testFlat']), 1);

      expect(
          const DeepCollectionEquality().equals(gottenMap, fakeMap['testFlat']),
          true);
    });

    test('should return defaultValue int', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gotten = container.get<int>(
          const CustomNotificationPath(strings: ['notAKey']), 5);

      expect(gotten, 5);
    });

    test('should return defaultValue map', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gottenMap = container
          .get<Map>(const CustomNotificationPath(strings: ['notAKey']), {});

      expect(const DeepCollectionEquality().equals(gottenMap, {}), true);
    });
  });

  group('freeze / unfreeze', () {
    final fakeMap = {
      'testFlat': 1,
      'testNested': {
        'multipleKeys': 2,
        'nestedVal': {'otherNested': 3}
      }
    };

    const path =
        CustomNotificationPath(strings: ['testNested', 'multipleKeys']);

    setUp(() {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode(fakeMap));
      when(() => getIt<LocalFileStore>().serialize(
          LocalStorageType.Notifications, any())).thenAnswer((_) async => null);
    });
    test('should not allow changes on freeze', () async {
      const SET_VALUE = 1;
      const NEW_VALUE = 7;

      final container = await NotificationContainer.getNotificationContainer();

      expect(container.get(path, 0), SET_VALUE);
      container.freeze(path);
      await container.set(path, NEW_VALUE);
      expect(container.get(path, 5), SET_VALUE);
      container.unfreeze(path);
      await container.set(path, NEW_VALUE);
      expect(container.get(path, 5), NEW_VALUE);
    });
  });
}
