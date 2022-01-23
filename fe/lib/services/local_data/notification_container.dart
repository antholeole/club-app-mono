import 'dart:convert';

import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/either.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'app_badger.dart';

abstract class NotificationPath {
  const NotificationPath();

  List<String> _getNotificationPath();
}

class GroupNotificationPath extends NotificationPath {
  final UuidType groupId;

  const GroupNotificationPath({required this.groupId});

  @override
  List<String> _getNotificationPath() {
    return ['group', groupId.uuid];
  }
}

class ThreadNotificationPath extends NotificationPath {
  final UuidType groupId;
  final UuidType threadId;

  const ThreadNotificationPath({required this.groupId, required this.threadId});

  @override
  List<String> _getNotificationPath() {
    return ['group', groupId.uuid, threadId.uuid];
  }
}

class DmNotificationPath extends NotificationPath {
  final UuidType dmId;

  const DmNotificationPath({required this.dmId});

  @override
  List<String> _getNotificationPath() {
    return ['dm', dmId.uuid];
  }
}

/// required to be in this folder due to overriding a private method. Alas!
@visibleForTesting
class CustomNotificationPath extends NotificationPath {
  final List<String> strings;

  const CustomNotificationPath({required this.strings});

  @override
  List<String> _getNotificationPath() {
    return strings;
  }
}

class NotificationContainer extends ChangeNotifier {
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  final _appBadger = getIt<AppBadger>();

  late final EitherMap<List<UuidType>> _notificationsCache;
  final EitherMap<bool> _freeze = EitherMap({});

  NotificationContainer._(Map<String, dynamic> notifications) {
    _notificationsCache = _deserializeEitherMap(notifications);
  }

  static EitherMap<List<UuidType>> _deserializeEitherMap(
      Map<String, dynamic> inputJson) {
    final EitherMap<List<UuidType>> building = EitherMap({});

    for (final entry in inputJson.entries) {
      if (entry.value is List) {
        building.add(
            entry.key,
            Either.first((entry.value as List<dynamic>)
                .map((e) => UuidType(e))
                .toList()));
      } else {
        building.add(
            entry.key, Either.second(_deserializeEitherMap(entry.value)));
      }
    }

    return building;
  }

  static Map<String, dynamic> _serializeEitherMap(
          EitherMap<List<UuidType>> eitherMap) =>
      Map.fromEntries(eitherMap.entries.map((mapEntry) => MapEntry(
          mapEntry.key,
          mapEntry.value.when(
              first: (val) => val.map((e) => e.uuid).toList(),
              second: (map) =>
                  NotificationContainer._serializeEitherMap(map)))));

  static Future<NotificationContainer> getNotificationContainer() async {
    final localFileStore = getIt<LocalFileStore>();
    final handler = getIt<Handler>();
    final notifications =
        await localFileStore.deserialize(LocalStorageType.Notifications);

    if (notifications != null) {
      try {
        return NotificationContainer._(json.decode(notifications));
      } on Exception catch (e) {
        await handler.reportUnknown(e, 'while decoding NotificationContainer');
      }
    }

    return NotificationContainer._({});
  }

  /// if path points to a subdirectory, we will recursively freeze
  /// all children.
  void freeze(NotificationPath path) {
    final parentMap = _getParentMap(path, _freeze);
    final lastKey = path._getNotificationPath().last;
    parentMap.add(lastKey, Either.first(true));
    _recursiveFreezeTravel(parentMap, lastKey, true);
  }

  /// if path points to a subdirectory, we will recursively unfreeze
  /// all children.
  void unfreeze(NotificationPath path) async {
    final parentMap = _getParentMap(path, _freeze);
    final lastKey = path._getNotificationPath().last;
    parentMap.add(lastKey, Either.first(false));
    _recursiveFreezeTravel(parentMap, path._getNotificationPath().last, false);
  }

  void _recursiveFreezeTravel(EitherMap<bool> parent, String key, bool setTo) {
    parent.get(key)!.when(
        first: (_) => parent.add(key, Either.first(setTo)),
        second: (map) => map.entries
            .forEach((entry) => _recursiveFreezeTravel(map, entry.key, setTo)));
  }

  /// MUST point to value, not submap
  Future<void> clear(NotificationPath path) => _updatePath(path, (_) => []);

  Future<void> add(NotificationPath path, UuidType value) =>
      _updatePath(path, (old) => List<UuidType>.from(old)..add(value));

  Future<void> _updatePath(NotificationPath path,
      List<UuidType> Function(List<UuidType> old) update) async {
    final lastPathNode = path._getNotificationPath().last;
    final isFrozen = _getParentMap(path, _freeze).get(lastPathNode);

    if (isFrozen != null &&
        isFrozen.when(
            first: (v) => v,
            second: (got) => throw IncorrectEitherMapTypeTraversal(
                lastPathNode, got.runtimeType, bool))) {
      return;
    }

    final parentMap = _getParentMap(path, _notificationsCache);
    final prev = parentMap.get(lastPathNode)?.when(
        first: (list) => list,
        second: (got) => throw IncorrectEitherMapTypeTraversal(
            lastPathNode, got.runtimeType, List));
    parentMap.add(lastPathNode, Either.first(update(prev ?? [])));

    notifyListeners();

    await _localFileStore.serialize(
        LocalStorageType.Notifications,
        json.encode(
            NotificationContainer._serializeEitherMap(_notificationsCache)));

    await _appBadger.set(_getAllNotificationsAtSubtree().length);
  }

  /// if path points to a subtree, will get all the uuids in the subtree
  /// if it points to a value, will get the uuids at that value
  List<UuidType>? get(NotificationPath path) {
    final parentMap = _getParentMap(path, _notificationsCache);
    final lastKey = path._getNotificationPath().last;

    if (parentMap.containsKey(lastKey)) {
      return parentMap.get(lastKey)!.when(
          first: (val) => val,
          second: (subtree) => _getAllNotificationsAtSubtree(subtree));
    }
  }

  EitherMap<T> _getParentMap<T>(NotificationPath path, EitherMap<T> baseMap) {
    EitherMap<T> currentJson = baseMap;
    final notificationPath = path._getNotificationPath();

    //notice iteration is one less
    for (int i = 0; i < notificationPath.length - 1; i++) {
      final segment = notificationPath[i];

      if (!currentJson.containsKey(segment)) {
        currentJson.add(segment, Either.second(EitherMap({})));
      }

      currentJson = currentJson.get(segment)!.when(
          first: (val) => throw IncorrectEitherMapTypeTraversal(
              segment, val.runtimeType, currentJson.runtimeType),
          second: (map) => map);
    }

    return currentJson;
  }

  List<UuidType> _getAllNotificationsAtSubtree(
      [EitherMap<List<UuidType>>? root]) {
    root ??= _notificationsCache;

    List<UuidType> notifications = [];
    for (final child in root.entries) {
      child.value.when(
          first: notifications.addAll,
          second: (map) =>
              notifications.addAll(_getAllNotificationsAtSubtree(map)));
    }

    return notifications;
  }
}
