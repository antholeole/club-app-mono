import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.var.gql.dart';
import 'package:fe/gql/query_all_groups_conditional_join_token.data.gql.dart';
import 'package:fe/gql/upsert_group_join_token.data.gql.dart';
import 'package:fe/gql/upsert_group_join_token.var.gql.dart';
import 'package:fe/gql/remove_self_from_group.data.gql.dart';
import 'package:fe/gql/remove_self_from_group.var.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final userId = UuidType('b833dddb-cf5c-4966-a137-f586d955b560');
  const failureMessage = 'fake';
  final groupId = UuidType('b454d579-c4d2-403c-95cd-ac8dbc97476a');
  const groupName = 'Sports Ball Team';
  const joinToken = 'asdasd';

  group('update groups cubit', () {
    setUp(() async {
      await registerAllMockServices();
      when(() => getIt<LocalUserService>().getLoggedInUserId())
          .thenAnswer((invocation) async => userId);
    });

    group('fetchGroups', () {
      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit failure on failure fetching groups',
          setUp: () {
            stubGqlResponse<GQueryAllGroupsConditionalJoinTokenData,
                    GQueryAllGroupsConditionalJoinTokenVars>(
                getIt<AuthGqlClient>(),
                error: (_) => const Failure(
                    status: FailureStatus.GQLMisc, message: failureMessage));
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.fetchGroups(),
          expect: () => [
                UpdateGroupsState.failure(const Failure(
                    status: FailureStatus.GQLMisc, message: failureMessage))
              ]);

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit group with join token on admin group',
          setUp: () {
            stubGqlResponse<GQueryAllGroupsConditionalJoinTokenData,
                    GQueryAllGroupsConditionalJoinTokenVars>(
                getIt<AuthGqlClient>(),
                data: (_) => GQueryAllGroupsConditionalJoinTokenData.fromJson({
                      'admin_groups': [
                        {
                          'group': {
                            'group_name': groupName,
                            'id': groupId.toString(),
                            'group_join_tokens': [
                              {'join_token': joinToken}
                            ]
                          }
                        }
                      ],
                      'member_groups': []
                    })!);
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.fetchGroups(),
          expect: () => [
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      leaveState: LeavingState.notLeaving(),
                      joinTokenState: JoinTokenState.adminWithToken(joinToken),
                      group: Group(admin: true, id: groupId, name: groupName))
                })
              ]);

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit group without join token on not admin group',
          setUp: () {
            stubGqlResponse<GQueryAllGroupsConditionalJoinTokenData,
                    GQueryAllGroupsConditionalJoinTokenVars>(
                getIt<AuthGqlClient>(),
                data: (_) => GQueryAllGroupsConditionalJoinTokenData.fromJson({
                      'admin_groups': [],
                      'member_groups': [
                        {
                          'group': {
                            'group_name': groupName,
                            'id': groupId.toString(),
                          }
                        }
                      ]
                    })!);
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.fetchGroups(),
          expect: () => [
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      leaveState: LeavingState.notLeaving(),
                      joinTokenState: JoinTokenState.notAdmin(),
                      group: Group(admin: false, id: groupId, name: groupName))
                })
              ]);
    });

    group('update group join token', () {
      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit failure on failure',
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken(null),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          setUp: () {
            stubGqlResponse<GUpsertGroupJoinTokenData,
                    GUpsertGroupJoinTokenVars>(getIt<AuthGqlClient>(),
                error: (_) => const Failure(
                    status: FailureStatus.GQLMisc, message: failureMessage));
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.updateGroupJoinToken(groupId),
          expect: () => [
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminLoading(),
                      leaveState: LeavingState.notLeaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
                UpdateGroupsState.failure(const Failure(
                    status: FailureStatus.GQLMisc, message: failureMessage))
              ]);

      String capturedNewJoinToken = 'NOT IT';
      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit new group with new join token on success',
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken(null),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          setUp: () {
            stubGqlResponse<GUpsertGroupJoinTokenData,
                    GUpsertGroupJoinTokenVars>(getIt<AuthGqlClient>(),
                data: (invocation) {
              capturedNewJoinToken = (invocation.positionalArguments[0]
                      as OperationRequest<GUpsertGroupJoinTokenData,
                          GUpsertGroupJoinTokenVars>)
                  .vars
                  .new_token!;

              return GUpsertGroupJoinTokenData.fromJson({
                'insert_group_join_tokens_one': {
                  'join_token': capturedNewJoinToken
                }
              })!;
            });
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.updateGroupJoinToken(groupId),
          expect: () => [
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminLoading(),
                      leaveState: LeavingState.notLeaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState:
                          JoinTokenState.adminWithToken(capturedNewJoinToken),
                      leaveState: LeavingState.notLeaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
              ]);

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit new group with no join token on delete',
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken('a token'),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          setUp: () {
            stubGqlResponse<GUpsertGroupJoinTokenData,
                    GUpsertGroupJoinTokenVars>(getIt<AuthGqlClient>(),
                data: (_) => GUpsertGroupJoinTokenData.fromJson({
                      'insert_group_join_tokens_one': {'join_token': null}
                    })!);
          },
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.updateGroupJoinToken(groupId, delete: true),
          expect: () => [
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminLoading(),
                      leaveState: LeavingState.notLeaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminWithToken(null),
                      leaveState: LeavingState.notLeaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
              ]);
    });

    group('leave group', () {
      MockCaller caller = MockCaller();

      setUp(() {
        reset(caller);
      });

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit groups with prompting leavestate',
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken('a token'),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          build: () => UpdateGroupsCubit(),
          act: (cubit) => cubit.leaveGroup(groupId, caller.call),
          expect: () => [
                isA<UpdateGroupsState>().having(
                    (ugs) => ugs.join(
                        (_) => null,
                        (fgs) => fgs.groups[groupId]!.leaveState.join(
                            (_) => null,
                            (_) => null,
                            (pls) => pls,
                            (_) => null),
                        (_) => null),
                    'leave state',
                    isA<PromptLeavingState>()),
              ]);

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'calling emitted callback should leave group and call caller',
          setUp: () {
            final mockCache = MockCache();
            when(() => getIt<AuthGqlClient>().cache).thenReturn(mockCache);
            when(() => mockCache.gc())
                .thenReturn(<String>{'im a set not a map'});

            stubGqlResponse<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
                getIt<AuthGqlClient>(),
                data: (_) => GRemoveSelfFromGroupData.fromJson({
                      'delete_user_to_group': {'affected_rows': 1}
                    })!);
          },
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken(null),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          build: () => UpdateGroupsCubit(),
          act: (cubit) async {
            await cubit.leaveGroup(groupId, caller.call);
            await cubit.state.groups![groupId]!.leaveState
                .join((_) => null, (_) => null, (pls) => pls, (_) => null)!
                .accepted();
          },
          expect: () => [
                isA<UpdateGroupsState>().having(
                    (ugs) => ugs.join(
                        (_) => null,
                        (fgs) => fgs.groups[groupId]!.leaveState.join(
                            (_) => null,
                            (_) => null,
                            (pls) => pls,
                            (_) => null),
                        (_) => null),
                    'leave state',
                    isA<PromptLeavingState>()),
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminWithToken(null),
                      leaveState: LeavingState.leaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
                UpdateGroupsState.fetched({})
              ],
          verify: (_) => verify(() => caller.call()).called(1));

      blocTest<UpdateGroupsCubit, UpdateGroupsState>(
          'should emit failure on failed to leave group',
          setUp: () {
            final mockCache = MockCache();
            when(() => getIt<AuthGqlClient>().cache).thenReturn(mockCache);
            when(() => mockCache.gc())
                .thenReturn(<String>{'im a set not a map'});

            when(() => getIt<Handler>().basicGqlErrorHandler(any())).thenAnswer(
                (_) async => const Failure(
                    status: FailureStatus.GQLMisc, message: failureMessage));

            stubGqlResponse<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
              getIt<AuthGqlClient>(),
              error: (_) => const Failure(
                  status: FailureStatus.GQLMisc, message: failureMessage),
            );
          },
          seed: () => UpdateGroupsState.fetched({
                groupId: GroupsPageGroup(
                    joinTokenState: JoinTokenState.adminWithToken(null),
                    leaveState: LeavingState.notLeaving(),
                    group: Group(admin: true, id: groupId, name: groupName))
              }),
          build: () => UpdateGroupsCubit(),
          act: (cubit) async {
            await cubit.leaveGroup(groupId, caller.call);
            await cubit.state.groups![groupId]!.leaveState
                .join((_) => null, (_) => null, (pls) => pls, (_) => null)!
                .accepted();
          },
          expect: () => [
                isA<UpdateGroupsState>().having(
                    (ugs) => ugs.join(
                        (_) => null,
                        (fgs) => fgs.groups[groupId]!.leaveState.join(
                            (_) => null,
                            (_) => null,
                            (pls) => pls,
                            (_) => null),
                        (_) => null),
                    'leave state',
                    isA<PromptLeavingState>()),
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminWithToken(null),
                      leaveState: LeavingState.leaving(),
                      group: Group(admin: true, id: groupId, name: groupName))
                }),
                UpdateGroupsState.fetched({
                  groupId: GroupsPageGroup(
                      joinTokenState: JoinTokenState.adminWithToken(null),
                      leaveState: LeavingState.failure(const Failure(
                          status: FailureStatus.GQLMisc,
                          message: failureMessage)),
                      group: Group(admin: true, id: groupId, name: groupName))
                })
              ]);
    });
  });
}
