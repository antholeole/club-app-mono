import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';
import 'package:fe/gql/query_verify_self_in_thread.req.gql.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

import 'thread_state.dart';
export 'thread_state.dart';

class ThreadCubit extends Cubit<ThreadState> {
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _gqlClient = getIt<AuthGqlClient>();
  final _localUserService = getIt<LocalUserService>();
  final _config = getIt<Config>();

  Group? currentGroup;

  ThreadCubit({required Group group, Thread? initalThread})
      : super(ThreadState.noThread()) {
    if (_config.testing) {
      currentGroup = group;
    } else {
      _newGroup(group);
    }

    if (initalThread != null) {
      emit(ThreadState.thread(initalThread));
    }
  }

  @override
  Future<void> close() async {
    await cacheThread();
    await super.close();
  }

  void switchToThread(Thread thread) {
    emit(ThreadState.thread(thread));
  }

  //public. caches thread before switching.
  Future<void> newGroup(Group group) async {
    await cacheThread();
    await _newGroup(group);
  }

  Future<void> cacheThread() async {
    if (!(currentGroup! is Club)) {
      return;
    }

    final key = _getCacheClubThreadKey((currentGroup as Club));

    final thread = state.thread;

    if (thread != null) {
      await _sharedPrefrences.setString(key, json.encode(thread.toJson()));
    } else {
      await _sharedPrefrences.remove(key);
    }
  }

  Thread? _getCachedThread(Club club) {
    final key = _getCacheClubThreadKey(club);
    final threadStr = _sharedPrefrences.getString(key);

    if (threadStr == null) {
      return null;
    }

    final thread = Thread.fromJson(json.decode(threadStr));
    //NOTE: thread from cache. Need client to verify that they
    //still are in that thread. otherwise it will error bad
    return thread;
  }

  Future<void> _newGroup(Group group) async {
    if (currentGroup == group) {
      return;
    }

    currentGroup = group;

    //if the group is a dm, we are good!
    if (group is Dm) {
      emit(ThreadState.thread(Thread(id: group.id, name: group.name)));
      return;
    }

    Thread? thread = _getCachedThread(group as Club);
    final userId = await _localUserService.getLoggedInUserId();

    //if we have a cached thread, switch to it and verify we're in it.
    if (thread != null) {
      emit(ThreadState.thread(thread));
      final stillIn = await _verifyStillInThread(thread);
      if (!stillIn) {
        emit(ThreadState.noThread());
      } else {
        return;
      }
    }

    try {
      final threads = await _gqlClient
          .request(GQuerySelfThreadsInGroupReq((q) => q
            ..vars.groupId = group.id
            ..vars.userId = userId))
          .first;

      if (threads.threads.isEmpty) {
        emit(ThreadState.noThread());
      } else {
        final threadData = threads.threads.first;
        emit(ThreadState.thread(
            Thread(id: threadData.id, name: threadData.name!)));
      }
    } on Failure catch (_) {
      // just in case we never emitted, emit here.
      // due to emit equality, if previous was no thread
      // nbd.
      emit(ThreadState.noThread());
      return;
    }
  }

  Future<bool> _verifyStillInThread(Thread thread) async {
    final userId = await _localUserService.getLoggedInUserId();

    try {
      final resp = await _gqlClient
          .request(GQueryVerifySelfInThreadReq((q) => q
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..vars.groupId = currentGroup!.id
            ..vars.userId = userId
            ..vars.threadId = thread.id))
          .first;

      return resp.threads_aggregate.aggregate!.count > 0;
    } catch (e) {
      //return true in case of error. we are still "in the thread"
      //in this state, as we still have it in our cache
      return true;
    }
  }

  String _getCacheClubThreadKey(Club group) {
    return 'group:${group.id.uuid}:thread';
  }
}
