import 'dart:convert';

import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/stdlib/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.req.gql.dart';

class ChatService {
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _gqlClient = getIt<Client>();
  final _localUserService = getIt<LocalUserService>();

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

  Future<bool> verifyStillInThread(Group group, Thread thread) async {
    final userId = await _localUserService.getLoggedInUserId();

    final resp = await gqlReqOrThrowFailure(
        GQuerySelfThreadsInGroupReq((q) => q
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..vars.groupId = group.id
          ..vars.userId = userId),
        _gqlClient);

    for (final groupThread in resp.group_threads) {
      if (groupThread.id == thread.id) {
        return true;
      }
    }

    return false;
  }

  Thread? getCachedThread(Group group) {
    final key = _getCacheThreadKey(group);
    final threadStr = _sharedPrefrences.getString(key);

    if (threadStr == null) {
      return null;
    }

    final thread = Thread.fromJson(threadStr);
    //NOTE: thread from cache. Need client to verify that they
    //still have access to data in thread. else, it will just be
    //a bunch of errors
    return thread;
  }

  Future<List<Message>> getChats(Thread thread, DateTime before) async {
    final resp = await gqlReqOrThrowFailure(
        GQueryMessagesInThreadReq((q) => q
          ..vars.before = before
          ..vars.threadId = thread.id),
        _gqlClient);

    return resp.messages
        .map((message) => Message(
            edited: message.updated_at != null,
            id: message.id,
            sender: User(
                name: message.user.name,
                profilePictureUrl: message.user.profile_picture,
                id: message.user.id),
            message: message.message,
            sentAt: message.created_at))
        .toList();
  }
}
