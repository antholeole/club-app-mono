import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/chat_page_message_display.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/message_display.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../test_helpers/pump_app.dart';

void main() {
  final fakeMessage = Message(
      user: User(id: UuidType.generate(), name: 'Luna beans'),
      id: UuidType.generate(),
      message: 'asdasd',
      isImage: false,
      createdAt: clock.now(),
      updatedAt: clock.now());

  final MockMessageOverlayCubit mockMessageOverlayCubit =
      MockMessageOverlayCubit.getMock();

  Widget wrapWithDependencies({required Widget child}) {
    return BlocProvider<MessageOverlayCubit>(
      create: (_) => mockMessageOverlayCubit,
      child: child,
    );
  }

  setUpAll(() {
    registerFallbackValue(LayerLink());
  });

  testWidgets('should call addReactionOverlay on short press', (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: ChatPageMessageDisplay(message: fakeMessage)));

    await tester.tap(find.byType(MessageDisplay));

    verify(() => mockMessageOverlayCubit.addReactionOverlay(
        layerLink: any(named: 'layerLink'), message: fakeMessage)).called(1);
  });

  testWidgets('should call addSettingsOverlay on long press', (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: ChatPageMessageDisplay(message: fakeMessage)));

    await tester.longPress(find.byType(MessageDisplay));

    verify(() => mockMessageOverlayCubit.addSettingsOverlay(
        layerLink: any(named: 'layerLink'), message: fakeMessage)).called(1);
  });
}
