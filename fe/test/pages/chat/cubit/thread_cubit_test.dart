import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart';
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart';

import 'package:fe/gql/query_verify_self_in_thread.data.gql.dart';
import 'package:fe/gql/query_verify_self_in_thread.var.gql.dart';
import 'package:fe/gql/query_verify_self_in_thread.req.gql.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/group.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final mockGroup = mockGroupAdmin;
  final mockGroup2 = mockGroupNotAdmin;
  final mockUserId = UuidType('d9ca66cd-4376-48ff-aec1-44c1b9093c74');

  setUp(() async {
    await registerAllMockServices();

    when(() => getIt<SharedPreferences>().setString(any(), any()))
        .thenAnswer((_) async => true);
    when(() => getIt<SharedPreferences>().remove(any()))
        .thenAnswer((_) async => true);
    when(() => getIt<LocalUserService>().getLoggedInUserId())
        .thenAnswer((_) async => mockUserId);
  });

  final mockThread =
      Thread(id: UuidType(const Uuid().v4()), name: 'fake thread');

  blocTest<ThreadCubit, ThreadState>(
      'switch to thread should emit thread being switched to',
      build: () => ThreadCubit(group: mockGroup),
      act: (cubit) => cubit.switchToThread(mockThread),
      expect: () => [ThreadState.thread(mockThread)]);

  group('cache thread', () {
    blocTest<ThreadCubit, ThreadState>(
      'should call cache thread on close',
      setUp: () =>
          when(() => getIt<SharedPreferences>().setString(any(), any()))
              .thenAnswer((invocation) async => false),
      build: () => ThreadCubit(group: mockGroupNotAdmin),
      act: (cubit) {
        cubit.switchToThread(mockThread);
        //cubits get auto closed...
      },
      verify: (_) =>
          verify(() => getIt<SharedPreferences>().setString(any(), any()))
              .called(1),
    );

    blocTest<ThreadCubit, ThreadState>(
      'should remove cached thread if no thread selected',
      setUp: () =>
          when(() => getIt<SharedPreferences>().setString(any(), any()))
              .thenAnswer((invocation) async => false),
      build: () => ThreadCubit(group: mockGroupNotAdmin),
      act: (cubit) => null, //cubits get auto closed, cache auto called
      verify: (_) =>
          verify(() => getIt<SharedPreferences>().remove(any())).called(1),
    );

    blocTest<ThreadCubit, ThreadState>(
      'should add cached thread if thread selected',
      setUp: () =>
          when(() => getIt<SharedPreferences>().setString(any(), any()))
              .thenAnswer((invocation) async => false),
      build: () => ThreadCubit(group: mockGroupNotAdmin),
      act: (cubit) => cubit.switchToThread(
          mockThread), //cubits get auto closed, cache auto called
      verify: (_) =>
          verify(() => getIt<SharedPreferences>().setString(any(), any()))
              .called(1),
    );
  });

  group('new group', () {
    blocTest<ThreadCubit, ThreadState>(
      'if newgroup == oldGroup newgroup should do nothing',
      build: () => ThreadCubit(group: mockGroup),
      act: (cubit) => cubit.newGroup(mockGroup),
      expect: () => [],
    );

    blocTest<ThreadCubit, ThreadState>('should cache thread',
        setUp: () {
          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                    'group_threads': [
                      {
                        'name': 'Meetups',
                        'id': '6481f35f-e444-494b-a980-c0a420384c61'
                      }
                    ]
                  })!);
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) {
          cubit.switchToThread(mockThread);
          cubit.newGroup(mockGroup2);
        },
        verify: (_) =>
            verify(() => getIt<SharedPreferences>().setString(any(), any()))
                .called(greaterThanOrEqualTo(1))); //also caches on close
  });

  group('on have cached thread', () {
    blocTest<ThreadCubit, ThreadState>('should emit thread if still in thread',
        setUp: () {
          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                    'group_threads_aggregate': {
                      'aggregate': {'count': 1}
                    }
                  })!);

          when(() => getIt<SharedPreferences>().getString(any()))
              .thenReturn(json.encode(mockThread.toJson()));
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) {
          cubit.newGroup(mockGroup2);
        },
        expect: () => [ThreadState.thread(mockThread)]);

    blocTest<ThreadCubit, ThreadState>(
        'should emit thread, then no thread, if not in thread',
        setUp: () {
          when(() => getIt<SharedPreferences>().getString(any()))
              .thenReturn(json.encode(mockThread.toJson()));

          stubGqlResponse<GQueryVerifySelfInThreadData,
                  GQueryVerifySelfInThreadVars>(getIt<Client>(),
              requestMatcher: isA<GQueryVerifySelfInThreadReq>(),
              data: (_) => GQueryVerifySelfInThreadData.fromJson({
                    'group_threads_aggregate': {
                      'aggregate': {'count': 0}
                    }
                  })!);

          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
              data: (_) => GQuerySelfThreadsInGroupData.fromJson(
                  {'group_threads': []})!);
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) => cubit.newGroup(mockGroup2),
        expect: () => [ThreadState.thread(mockThread), ThreadState.noThread()]);
  });

  group('on no cached thread', () {
    setUp(() {
      when(() => getIt<SharedPreferences>().getString(any())).thenReturn(null);
    });
    blocTest<ThreadCubit, ThreadState>(
        'if api call returns no thread should emit no thread',
        setUp: () {
          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
              data: (_) => GQuerySelfThreadsInGroupData.fromJson(
                  {'group_threads': []})!);
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) => cubit.newGroup(mockGroup2),
        expect: () => [ThreadState.noThread()]);

    blocTest<ThreadCubit, ThreadState>(
        'if api call returns thread should emit first thread',
        setUp: () {
          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
              data: (_) => GQuerySelfThreadsInGroupData.fromJson({
                    'group_threads': [
                      mockThread.toJson(),
                      {
                        'name': 'thread2',
                        'id': '3481f35f-e444-494b-a980-c0a420384c61'
                      }
                    ]
                  })!);
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) => cubit.newGroup(mockGroup2),
        expect: () => [ThreadState.thread(mockThread)]);

    blocTest<ThreadCubit, ThreadState>(
        'if api call errors should emit no thread',
        setUp: () {
          stubGqlResponse<GQuerySelfThreadsInGroupData,
                  GQuerySelfThreadsInGroupVars>(getIt<Client>(),
              requestMatcher: isA<GQuerySelfThreadsInGroupReq>(),
              errors: (_) => [const GraphQLError(message: 'fake error')]);

          when(() => getIt<Handler>().basicGqlErrorHandler(any())).thenAnswer(
              (_) async => const Failure(status: FailureStatus.GQLMisc));
        },
        build: () => ThreadCubit(group: mockGroup),
        act: (cubit) => cubit.newGroup(mockGroup2),
        expect: () => [ThreadState.noThread()]);
  });
}
