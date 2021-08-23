import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/gql/query_messages_in_thread.var.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';
import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  final mockMessageOne = {
    'created_at': '2021-08-06T15:56:37.191179+00:00',
    'message': 'eaque rerum! Provident similique accusantium',
    'user': {
      'name': 'Brit B',
      'profile_picture': null,
      'id': 'd3ac2f6b-e56f-47d2-9121-c5444b959a3f'
    },
    'is_image': false,
    'updated_at': '2021-08-06T15:56:37.191179+00:00',
    'id': '4b5a9e5b-0f35-4f4e-bfc5-44764f12d4ae'
  };

  final mockMessageTwo = {
    'created_at': '2020-08-06T15:56:37.191179+00:00',
    'message': 'msg2',
    'user': {
      'name': 'Brit B',
      'profile_picture': null,
      'id': 'd3ac2f6b-e56f-47d2-9121-c5444b959a3f'
    },
    'is_image': false,
    'updated_at': '2021-08-06T15:56:37.191179+00:00',
    'id': '4b5a9e5b-0f35-4f4e-bfc5-44764f12d4ae'
  };

  group('chat cubit', () {
    final mockThread =
        Thread(name: 'threadthread', id: UuidType(const Uuid().v4()));

    setUp(() {
      registerAllMockServices();
    });

    group('get chats', () {
      const mockError = 'im an error';
      blocTest<ChatCubit, ChatState>('should emit failure on failure',
          setUp: () {
            stubGqlResponse<GQueryMessagesInThreadData,
                    GQueryMessagesInThreadVars>(getIt<Client>(),
                errors: (_) => [const GraphQLError(message: mockError)]);

            when(() => getIt<Handler>().basicGqlErrorHandler(any())).thenAnswer(
                (_) async => const Failure(
                    status: FailureStatus.GQLMisc, message: mockError));
          },
          build: () => ChatCubit(),
          act: (cubit) => cubit.getChats(mockThread, DateTime(1)),
          expect: () => [
                ChatState.failure(const Failure(
                    status: FailureStatus.GQLMisc, message: mockError))
              ],
          verify: (cubit) => cubit.state.join(
              (_) => fail('incorrect state'),
              (_) => fail('incorrect state'),
              (cfmf) => expect(cfmf.failure.message, contains(mockError))));

      blocTest<ChatCubit, ChatState>(
        'should emit fetched message on fetched messages',
        setUp: () {
          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<Client>(),
              requestMatcher: isA<GQueryMessagesInThreadReq>(),
              data: (_) => GQueryMessagesInThreadData.fromJson({
                    'messages': [
                      mockMessageOne,
                      mockMessageTwo,
                    ]
                  })!);
        },
        build: () => ChatCubit(),
        act: (cubit) async {
          await cubit.getChats(mockThread, DateTime(1));
        },
        expect: () => [
          ChatState.fetchedMessages([
            Message.fromJson(mockMessageOne),
            Message.fromJson(mockMessageTwo)
          ], Message.fromJson(mockMessageOne).createdAt)
        ],
      );

      blocTest<ChatCubit, ChatState>(
        'should emit empty fetched message on no fetched messages',
        setUp: () {
          stubGqlResponse<GQueryMessagesInThreadData,
                  GQueryMessagesInThreadVars>(getIt<Client>(),
              data: (_) =>
                  GQueryMessagesInThreadData.fromJson({'messages': []})!);
        },
        build: () => ChatCubit(),
        act: (cubit) => cubit.getChats(mockThread, DateTime(1)),
        expect: () => [ChatState.fetchedMessages([], null)],
      );
    });
  });
}
