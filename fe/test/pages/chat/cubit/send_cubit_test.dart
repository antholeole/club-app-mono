import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/bloc/chat_bloc.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_state.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';

void main() {
  final MockThreadCubit mockThreadCubit = MockThreadCubit.getMock();
  final MockChatBloc mockChatBloc = MockChatBloc.getMock();

  const messageStr = 'asdas';

  setUp(() {
    registerAllMockServices();
  });

  void stubBlocsEmpty() {
    whenListen<ThreadState>(mockThreadCubit, const Stream.empty());
    whenListen<ChatState>(mockChatBloc, const Stream.empty());
  }

  blocTest<SendCubit, List<SendState>>('should add sending state on send',
      setUp: stubBlocsEmpty,
      build: () =>
          SendCubit(threadCubit: mockThreadCubit, chatBloc: mockChatBloc),
      act: (cubit) => cubit.send(messageStr),
      expect: () => []);
  //send should add sending state
  //send should call send API
  //send failure should emit sending failure
  //send success (chat bloc recieve same ID) should remove send state
  //thread switch shgould empty sending
}
