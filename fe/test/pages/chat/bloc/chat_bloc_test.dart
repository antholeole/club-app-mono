import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/gql/query_messages_in_chat.data.gql.dart';
import 'package:fe/gql/query_messages_in_chat.var.gql.dart';
import 'package:fe/gql/query_messages_in_chat.req.gql.dart';
import 'package:fe/gql/get_new_messages.data.gql.dart';
import 'package:fe/gql/get_new_messages.var.gql.dart';
import 'package:fe/gql/get_new_messages.req.gql.dart';
import 'package:fe/gql/get_new_reactions.data.gql.dart';
import 'package:fe/gql/get_new_reactions.var.gql.dart';
import 'package:fe/gql/get_new_reactions.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  fakeAsync((fakeAsync) {
    final fakeThread1 = Thread(name: 'asdiasjd', id: UuidType.generate());
    final fakeTime = clock.ago(days: 1);
    final fakeUser = User(name: 'Joshua', id: UuidType.generate());
    final fakeMessage1 = Message(
        user: fakeUser,
        id: UuidType.generate(),
        message: 'I might be donw',
        isImage: false,
        createdAt: fakeTime,
        updatedAt: fakeTime);

    void stubRequests() {
      stubGqlResponse<GGetNewMessagesData, GGetNewMessagesVars>(
          getIt<AuthGqlClient>(),
          data: (_) => GGetNewMessagesData.fromJson({'messages': []})!,
          requestMatcher: isA<GGetNewMessagesReq>());
      stubGqlResponse<GGetNewReactionsData, GGetNewReactionsVars>(
          getIt<AuthGqlClient>(),
          data: (_) =>
              GGetNewReactionsData.fromJson({'message_reactions': []})!,
          requestMatcher: isA<GGetNewReactionsReq>());
    }

    setUp(() {
      registerAllMockServices();
    });

    group('fetch messages', () {
      setUp(() {
        stubRequests();
      });

      blocTest<ChatBloc, ChatState>(
          "should fetch with 'before' as earliest contained message sent if messages in current state",
          setUp: () {
            stubGqlResponse<GQueryMessagesInChatData, GQueryMessagesInChatVars>(
                getIt<AuthGqlClient>(),
                data: (_) => GQueryMessagesInChatData.fromJson({
                      'messages': [
                        {
                          'created_at':
                              fakeMessage1.createdAt.toIso8601String(),
                          'message': fakeMessage1.message,
                          'user': {
                            'name': fakeUser.name,
                            'profile_picture': null,
                            'id': fakeUser.id.uuid,
                          },
                          'message_reactions': [],
                          'is_image': false,
                          'updated_at':
                              fakeMessage1.updatedAt.toIso8601String(),
                          'id': fakeMessage1.id.uuid
                        }
                      ]
                    })!,
                requestMatcher: isA<GQueryMessagesInChatReq>());
          },
          build: () => ChatBloc(thread: fakeThread1),
          act: (bloc) async {
            await Future.delayed(
                const Duration(milliseconds: 5)); //let the inital req finish
            bloc.add(const FetchMessagesEvent());
          },
          expect: () => [
                ChatState.loading(),
                ChatState.fetchedMessages(FetchedMessages(
                    messages: [fakeMessage1], hasReachedMax: true))
              ],
          verify: (_) => expect(
              verify(() => getIt<AuthGqlClient>().request(captureAny(
                  that: isA<GQueryMessagesInChatReq>().having(
                      (req) => req.vars.before,
                      'before',
                      equals(fakeMessage1.createdAt))))).captured,
              isNotNull));

      blocTest<ChatBloc, ChatState>(
          "should fetch with 'before' as time in future if no messages in current state",
          setUp: () {
            stubGqlResponse<GQueryMessagesInChatData, GQueryMessagesInChatVars>(
                getIt<AuthGqlClient>(),
                data: (_) =>
                    GQueryMessagesInChatData.fromJson({'messages': []})!,
                requestMatcher: isA<GQueryMessagesInChatReq>());
          },
          seed: () => ChatState.fetchedMessages(FetchedMessages(messages: [])),
          build: () => ChatBloc(thread: fakeThread1),
          act: (bloc) => bloc.add(const FetchMessagesEvent()),
          expect: () => [
                ChatState.loading(),
                ChatState.fetchedMessages(
                    FetchedMessages(messages: [], hasReachedMax: true))
              ],
          verify: (_) => expect(
              (verify(() => getIt<AuthGqlClient>().request(captureAny()))
                      .captured
                      .first as GQueryMessagesInChatReq)
                  .vars
                  .before
                  .compareTo(clock.now()),
              greaterThan(0)));

      group('has reached max', () {
        setUp(() {
          stubRequests();
        });

        blocTest<ChatBloc, ChatState>(
            'should be false if more than single query limit',
            setUp: () {
              stubGqlResponse<GQueryMessagesInChatData,
                      GQueryMessagesInChatVars>(getIt<AuthGqlClient>(),
                  data: (_) => GQueryMessagesInChatData.fromJson({
                        'messages': List.filled(20, {
                          'created_at':
                              fakeMessage1.createdAt.toIso8601String(),
                          'message': fakeMessage1.message,
                          'user': {
                            'name': fakeUser.name,
                            'profile_picture': null,
                            'id': fakeUser.id.uuid,
                          },
                          'message_reactions': [],
                          'is_image': false,
                          'updated_at':
                              fakeMessage1.updatedAt.toIso8601String(),
                          'id': fakeMessage1.id.uuid
                        })
                      })!,
                  requestMatcher: isA<GQueryMessagesInChatReq>());
            },
            build: () => ChatBloc(thread: fakeThread1),
            act: (bloc) {
              bloc.add(const FetchMessagesEvent());
            },
            expect: () => [
                  ChatState.loading(),
                  ChatState.fetchedMessages(FetchedMessages(
                      messages: List.filled(20, fakeMessage1),
                      hasReachedMax: false))
                ]);

        blocTest<ChatBloc, ChatState>(
            'should be true if less than single query limit',
            setUp: () {
              stubGqlResponse<GQueryMessagesInChatData,
                      GQueryMessagesInChatVars>(getIt<AuthGqlClient>(),
                  data: (_) => GQueryMessagesInChatData.fromJson({})!,
                  requestMatcher: isA<GQueryMessagesInChatReq>());
            },
            seed: () =>
                ChatState.fetchedMessages(FetchedMessages(messages: [])),
            build: () => ChatBloc(thread: fakeThread1),
            act: (bloc) {
              bloc.add(const FetchMessagesEvent());
            },
            expect: () => [
                  ChatState.loading(),
                  ChatState.fetchedMessages(
                      FetchedMessages(messages: [], hasReachedMax: true))
                ]);
      });
    });

    group('streams', () {
      group('reactions', () {
        late StreamController<GGetNewReactionsData> newReactionsStream;

        final Reaction fakeReaction = Reaction(
            type: ReactionType.Angry,
            id: UuidType.generate(),
            likedBy: fakeUser,
            messageId: fakeMessage1.id);

        setUp(() {
          newReactionsStream = StreamController();

          stubGqlResponse<GGetNewMessagesData, GGetNewMessagesVars>(
              getIt<AuthGqlClient>(),
              data: (_) => GGetNewMessagesData.fromJson({'messages': []})!,
              requestMatcher: isA<GGetNewMessagesReq>());

          when(() => getIt<AuthGqlClient>()
                  .request(any(that: isA<GGetNewReactionsReq>())))
              .thenAnswer((_) => newReactionsStream.stream);
        });

        blocTest<ChatBloc, ChatState>('should add reaction on reaction added',
            setUp: () {
              stubGqlResponse<GQueryMessagesInChatData,
                      GQueryMessagesInChatReq>(getIt<AuthGqlClient>(),
                  data: (_) => GQueryMessagesInChatData.fromJson({
                        'messages': [
                          {
                            'created_at':
                                fakeMessage1.createdAt.toIso8601String(),
                            'message': fakeMessage1.message,
                            'user': {
                              'name': fakeUser.name,
                              'profile_picture': null,
                              'id': fakeUser.id.uuid,
                            },
                            'message_reactions': [],
                            'is_image': false,
                            'updated_at':
                                fakeMessage1.updatedAt.toIso8601String(),
                            'id': fakeMessage1.id.uuid
                          }
                        ]
                      })!,
                  requestMatcher: isA<GQueryMessagesInChatReq>());
            },
            build: () => ChatBloc(thread: fakeThread1),
            act: (_) async {
              newReactionsStream.add(GGetNewReactionsData.fromJson({
                'message_reactions': [
                  {
                    'created_at': clock.now().toIso8601String(),
                    'user': {
                      'id': fakeUser.id.uuid,
                      'name': fakeUser.name,
                    },
                    'reaction_type': 'ANGRY',
                    'deleted': false,
                    'message': {'id': fakeMessage1.id.uuid},
                    'id': fakeReaction.id.uuid
                  }
                ]
              })!);
              await Future.delayed(const Duration(milliseconds: 5));
            },
            expect: () => [
                  ChatState.loading(),
                  ChatState.fetchedMessages(FetchedMessages(
                      messages: [fakeMessage1], hasReachedMax: true)),
                  ChatState.fetchedMessages(FetchedMessages(messages: [
                    fakeMessage1.copyWithNewReaction(fakeReaction)
                  ], hasReachedMax: true)),
                ]);

        blocTest<ChatBloc, ChatState>(
            'should remove reaction on reaction deleted',
            setUp: () {
              stubGqlResponse<GQueryMessagesInChatData,
                      GQueryMessagesInChatReq>(getIt<AuthGqlClient>(),
                  data: (_) => GQueryMessagesInChatData.fromJson({
                        'messages': [
                          {
                            'created_at':
                                fakeMessage1.createdAt.toIso8601String(),
                            'message': fakeMessage1.message,
                            'user': {
                              'name': fakeUser.name,
                              'profile_picture': null,
                              'id': fakeUser.id.uuid,
                            },
                            'message_reactions': [
                              {
                                'user': {
                                  'id': fakeUser.id.uuid,
                                  'name': fakeUser.name,
                                },
                                'message_reaction_type': {
                                  'reaction_type': 'ANGRY'
                                },
                                'reaction_type': 'ANGRY',
                                'deleted': false,
                                'id': fakeReaction.id.uuid
                              }
                            ],
                            'is_image': false,
                            'updated_at':
                                fakeMessage1.updatedAt.toIso8601String(),
                            'id': fakeMessage1.id.uuid
                          }
                        ]
                      })!,
                  requestMatcher: isA<GQueryMessagesInChatReq>());
            },
            build: () => ChatBloc(thread: fakeThread1),
            act: (_) async {
              newReactionsStream.add(GGetNewReactionsData.fromJson({
                'message_reactions': [
                  {
                    'created_at': clock.now().toIso8601String(),
                    'user': {
                      'id': fakeUser.id.uuid,
                      'name': fakeUser.name,
                    },
                    'reaction_type': 'ANGRY',
                    'deleted': true,
                    'message': {'id': fakeMessage1.id.uuid},
                    'id': fakeReaction.id.uuid
                  }
                ]
              })!);
              await Future.delayed(const Duration(milliseconds: 5));
            },
            expect: () => [
                  ChatState.loading(),
                  ChatState.fetchedMessages(FetchedMessages(messages: [
                    fakeMessage1.copyWithNewReaction(fakeReaction)
                  ], hasReachedMax: true)),
                  ChatState.fetchedMessages(FetchedMessages(messages: [
                    fakeMessage1.copyWithoutReaction(fakeReaction)
                  ], hasReachedMax: true)),
                ]);
      });

      group('messages', () {
        StreamController<GGetNewMessagesData> newMessagesStream =
            StreamController();

        setUp(() {
          stubGqlResponse<GQueryMessagesInChatData, GQueryMessagesInChatReq>(
              getIt<AuthGqlClient>(),
              data: (_) => GQueryMessagesInChatData.fromJson({'messages': []})!,
              requestMatcher: isA<GQueryMessagesInChatReq>());
          stubGqlResponse<GGetNewReactionsData, GGetNewReactionsVars>(
              getIt<AuthGqlClient>(),
              data: (_) =>
                  GGetNewReactionsData.fromJson({'message_reactions': []})!,
              requestMatcher: isA<GGetNewReactionsReq>());
          when(() => getIt<AuthGqlClient>()
                  .request(any(that: isA<GGetNewMessagesReq>())))
              .thenAnswer((_) => newMessagesStream.stream);
        });

        blocTest<ChatBloc, ChatState>('should add message on message added',
            build: () => ChatBloc(thread: fakeThread1),
            act: (_) => newMessagesStream.add(GGetNewMessagesData.fromJson({
                  'messages': [
                    {
                      'created_at': fakeMessage1.createdAt.toIso8601String(),
                      'message': fakeMessage1.message,
                      'user': {
                        'name': fakeUser.name,
                        'profile_picture': null,
                        'id': fakeUser.id.uuid,
                      },
                      'message_reactions': [],
                      'is_image': false,
                      'updated_at': fakeMessage1.updatedAt.toIso8601String(),
                      'id': fakeMessage1.id.uuid
                    }
                  ]
                })!),
            expect: () => [
                  ChatState.loading(),
                  ChatState.fetchedMessages(
                      FetchedMessages(messages: [], hasReachedMax: true)),
                  ChatState.fetchedMessages(FetchedMessages(
                      messages: [fakeMessage1], hasReachedMax: true))
                ]);
      });
    });
  });
}
