import 'dart:convert';

import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';

class ChatService {
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _gqlClient = getIt<Client>();

  String _getCacheThreadKey(Group group) {
    return 'group:${group.id.uuid}:thread';
  }

  Future<void> cacheThread(Group group, Thread? currentThread) async {
    final key = _getCacheThreadKey(group);

    if (currentThread != null) {
      await _sharedPrefrences.setString(
          key, json.encode(currentThread.toJson()));
    } else {
      await _sharedPrefrences.remove(key);
    }
  }

  Future<bool> verifyStillInThread(Group group, UuidType threadId) async {
    final resp = await gqlReqOrThrowFailure(
        GQuerySelfThreadsInGroupReq((q) => q
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..vars.groupId = group.id),
        _gqlClient);

    for (final groupThread in resp.group_threads) {
      if (groupThread.id == threadId) {
        return true;
      }
    }

    return false;
  }

  Thread? getCachedThread(Group group) {
    final key = _getCacheThreadKey(group);
    final thread = _sharedPrefrences.getString(key);

    if (thread == null) {
      return null;
    }

    //NOTE: thread from cache. Need client to verify that they
    //still have access to data in thread. else, it will just be
    //a bunch of errors
    return Thread.fromJson(json.decode(thread));
  }
}
