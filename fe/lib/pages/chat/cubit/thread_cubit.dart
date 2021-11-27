import 'package:bloc/bloc.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';

import '../../../service_locator.dart';

import 'thread_state.dart';
export 'thread_state.dart';

class ThreadCubit extends Cubit<ThreadState> {
  final _gqlClient = getIt<AuthGqlClient>();
  final _localUserService = getIt<LocalUserService>();

  Group? currentGroup;

  ThreadCubit({required Group group, Thread? initalThread})
      : super(initalThread == null
            ? ThreadState.noThread()
            : ThreadState.thread(initalThread)) {
    newGroup(group);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void switchToThread(Thread thread) {
    emit(ThreadState.thread(thread));
  }

  Future<void> newGroup(Group group) async {
    if (currentGroup == group) {
      return;
    }

    currentGroup = group;

    //if the group is a dm, we are good!
    if (group is Dm) {
      emit(ThreadState.thread(
          Thread(id: group.id, name: group.name, isViewOnly: false)));
      return;
    }

    final userId = await _localUserService.getLoggedInUserId();

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
            Thread(id: threadData.id, name: threadData.name)));
      }
    } on Failure catch (_) {
      emit(ThreadState.noThread());
      return;
    }
  }
}
