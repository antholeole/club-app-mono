import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_state.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/stub_gql_response.dart';
import 'package:fe/gql/insert_message.data.gql.dart';
import 'package:fe/gql/insert_message.var.gql.dart';
import 'package:fe/gql/insert_message.req.gql.dart';

void main() {
  final MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
  final MockChatBloc mockChatBloc = MockChatBloc.getMock();

  final fakeThread = Thread(id: UuidType.generate(), name: 'asdsad');
  final fakeUserId = UuidType.generate();

  const messageStr = 'asdas';

  setUp(() {
    registerAllMockServices();
  });

  blocTest<SendCubit, List<SendState>>('should add sending state on send',
      setUp: () {
        whenListen<ThreadState>(mockThreadCubit, const Stream.empty(),
            initialState: ThreadState.thread(fakeThread));
        whenListen<ChatState>(mockChatBloc, const Stream.empty());
        when(() => getIt<LocalUserService>().getLoggedInUserId())
            .thenAnswer((_) async => fakeUserId);

        stubGqlResponse<GInsertMessageData, GInsertMessageVars>(
            getIt<AuthGqlClient>(),
            data: (_) => GInsertMessageData.fromJson({})!);
      },
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) {
        cubit.send(messageStr);
      },
      expect: () => [
            contains(isA<SendState>().having(
                (state) => state.join((p0) => p0, (p0) => null),
                'state',
                isA<Sending>().having((sending) => sending.message.message,
                    'message', messageStr))),
            []
          ],
      verify: (_) {
        verify(() => getIt<AuthGqlClient>()
            .request(any(that: isA<GInsertMessageReq>()))).called(1);
      });

  //send failure should emit sending failure
  //send success (chat bloc recieve same ID) should remove send state
  //thread switch shgould empty sending
}
