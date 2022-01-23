import 'dart:convert';

import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/app_badger.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/helpers/either.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/get_it_helpers.dart';

void main() {
  Map<String, dynamic> getCapturedMap([int nth = 0]) {
    return json.decode(verify(() => getIt<LocalFileStore>().serialize(
        LocalStorageType.Notifications, captureAny())).captured[nth]);
  }

  List<String> getRandomUuidList(int count) {
    List<String> list = [];

    for (int i = 0; i < count; i++) {
      list.add(UuidType.generate().uuid);
    }

    return list;
  }

  void expectDeepEquals(dynamic groupOne, dynamic groupTwo) {
    expect(const DeepCollectionEquality().equals(groupOne, groupTwo), true);
  }

  setUp(() {
    registerAllMockServices();
  });

  group('constructor', () {
    test('should deserialize input json', () async {
      final flatList = getRandomUuidList(1);
      final multipleKeys = getRandomUuidList(2);
      final deepNested = getRandomUuidList(3);

      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode({
                'testFlat': flatList,
                'testNested': {
                  'multipleKeys': multipleKeys,
                  'nestedVal': {'otherNested': deepNested}
                }
              }));

      final container = await NotificationContainer.getNotificationContainer();

      expect(
          container.get(
            const CustomNotificationPath(strings: ['invalidField', 'blah']),
          ),
          null);

      expectDeepEquals(
          container.get(const CustomNotificationPath(strings: ['testFlat'])),
          flatList.map((e) => UuidType(e)).toList());

      expectDeepEquals(
          container.get(const CustomNotificationPath(
              strings: ['testNested', 'multipleKeys'])),
          multipleKeys.map((e) => UuidType(e)).toList());

      expectDeepEquals(
          container.get(const CustomNotificationPath(
              strings: ['testNested', 'nestedVal', 'otherNested'])),
          deepNested.map((e) => UuidType(e)).toList());
    });
  });

  group('set', () {
    setUp(() {
      when(() => getIt<AppBadger>().set(any())).thenAnswer((_) async => null);
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode({}));
      when(() => getIt<LocalFileStore>().serialize(
          LocalStorageType.Notifications, any())).thenAnswer((_) async => null);
    });

    group('should add at path', () {
      test('flat', () async {
        final container =
            await NotificationContainer.getNotificationContainer();
        final added = UuidType.generate();
        await container.add(
            const CustomNotificationPath(strings: ['testFlat']), added);

        expectDeepEquals(getCapturedMap(), {
          'testFlat': [added.uuid]
        });
      });

      test('nested', () async {
        final container =
            await NotificationContainer.getNotificationContainer();
        final added = UuidType.generate();
        await container.add(
            const CustomNotificationPath(strings: ['test', 'nested', 'stuff']),
            added);

        expectDeepEquals(
          getCapturedMap(),
          {
            'test': {
              'nested': {
                'stuff': [added.uuid]
              }
            }
          },
        );
      });

      test('multipleKeys', () async {
        final added = UuidType.generate();
        final container =
            await NotificationContainer.getNotificationContainer();
        await container.add(
            const CustomNotificationPath(strings: ['testFlatAgain']), added);
        await container.add(
            const CustomNotificationPath(strings: ['testFlat']), added);

        expectDeepEquals(getCapturedMap(1), {
          'testFlat': [added.uuid],
          'testFlatAgain': [added.uuid]
        });
      });
    });

    test('should throw if set at already written path', () async {
      final added = UuidType.generate();
      final container = await NotificationContainer.getNotificationContainer();
      await container.add(
          const CustomNotificationPath(strings: ['blah', 'nested']), added);
      expect(
          () async => await container.add(
              const CustomNotificationPath(strings: ['blah']), added),
          throwsA(isA<IncorrectEitherMapTypeTraversal>()));
    });

    test('should notify listeners', () async {
      final added = UuidType.generate();
      final container = await NotificationContainer.getNotificationContainer();

      bool listenerTrigged = false;
      container.addListener(() {
        listenerTrigged = true;
      });

      await container.add(
          const CustomNotificationPath(strings: ['blah', 'nested']), added);

      expect(listenerTrigged, true,
          reason: 'listener should have flipped bool');
    });

    test('should call appBadger with correct number', () async {
      final added = UuidType.generate();
      final container = await NotificationContainer.getNotificationContainer();

      const addedCount = 10;
      for (int i = 0; i < addedCount; i++) {
        await container.add(
            const CustomNotificationPath(strings: ['blah', 'nested']), added);
      }
      final capturedList =
          verify(() => getIt<AppBadger>().set(captureAny())).captured;
      for (int i = 0; i < addedCount - 1; i++) {
        expect(i + 1, capturedList[i]);
      }
    });
  });

  group('get', () {
    final Map<String, dynamic> fakeMap = {
      'testFlat': getRandomUuidList(2),
      'testNested': {
        'multipleKeys': getRandomUuidList(2),
        'nestedVal': {'otherNested': getRandomUuidList(3)}
      }
    };

    setUp(() {
      when(() => getIt<LocalFileStore>()
              .deserialize(LocalStorageType.Notifications))
          .thenAnswer((_) async => json.encode(fakeMap));
    });

    test('should return added subtree', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gottenMap =
          container.get(const CustomNotificationPath(strings: ['testNested']));

      expectDeepEquals(
          gottenMap,
          [
            ...fakeMap['testNested']['multipleKeys'],
            ...fakeMap['testNested']['nestedVal']['otherNested']
          ].map((e) => UuidType(e)).toList());
    });

    test('should return uuid List', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gottenList =
          container.get(const CustomNotificationPath(strings: ['testFlat']));

      expectDeepEquals(
          gottenList, fakeMap['testFlat'].map((e) => UuidType(e)).toList());
    });

    test('should return null if no path', () async {
      final container = await NotificationContainer.getNotificationContainer();

      final gotten =
          container.get(const CustomNotificationPath(strings: ['notAKey']));

      expect(gotten, null);
    });
  });

  group('freeze / unfreeze', () {
    final Map<String, dynamic> fakeMap = {
      'testFlat': getRandomUuidList(2),
      'testNested': {
        'multipleKeys': getRandomUuidList(2),
        'nestedVal': {'otherNested': getRandomUuidList(3)}
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
      final container = await NotificationContainer.getNotificationContainer();
      final pathAsUuids = fakeMap['testNested']['multipleKeys']
          .map((v) => UuidType(v))
          .toList();

      expectDeepEquals(container.get(path), pathAsUuids);
      container.freeze(path);
      await container.add(path, UuidType.generate());
      expectDeepEquals(container.get(path), pathAsUuids);
    });
  });
}
