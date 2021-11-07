import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/data_carriers/sending_message.dart';
import 'package:fe/pages/chat/cubit/send_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/sending_message.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../test_helpers/pump_app.dart';

void main() {
  final fakeUser = User(name: 'asdasdaoksmnon', id: UuidType.generate());

  Widget wrapWithDependencies({required Widget child}) {
    return BlocProvider<UserCubit>(
      create: (_) => UserCubit(fakeUser),
      child: child,
    );
  }

  setUp(() {
    registerAllMockServices();
  });

  testWidgets('should display loader on loading state', (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: SendingMessageDisplay(
      sendState: SendState.sending(message: SendingMessage(message: 'asdasds')),
    )));

    expect(find.byType(Loader), findsOneWidget);
  });

  testWidgets('should display error on error state', (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: SendingMessageDisplay(
      sendState: SendState.failure(
          failure: Failure(status: FailureStatus.NoConn),
          resend: () async {},
          message: SendingMessage(message: 'asdasds')),
    )));

    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });

  testWidgets('should call refresh on click refresh on error', (tester) async {
    final MockCaller caller = MockCaller();

    await tester.pumpApp(wrapWithDependencies(
        child: SendingMessageDisplay(
      sendState: SendState.failure(
          failure: Failure(status: FailureStatus.NoConn),
          resend: () async => caller.call(),
          message: SendingMessage(message: 'asdasds')),
    )));

    await tester.tap(find.byIcon(Icons.refresh));

    verify(() => caller.call()).called(1);
  });
}
