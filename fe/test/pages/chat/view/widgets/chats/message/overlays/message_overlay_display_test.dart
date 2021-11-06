import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/hold_overlay/message_options_overlay.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/message_overlay_display.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/message_reaction_overlay.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../test_helpers/pump_app.dart';
import '../../../../../../../test_helpers/stub_bloc_stream.dart';

void main() {
  final fakeUser = User(name: 'asdasdas', id: UuidType.generate());
  final fakeMessage = Message(
      user: fakeUser,
      id: UuidType.generate(),
      message: 'hi',
      isImage: false,
      createdAt: clock.now(),
      updatedAt: clock.now());

  final mockMessageOverlayCubit = MockMessageOverlayCubit.getMock();
  final mockToasterCubit = MockToasterCubit.getMock();

  Widget wrapWithDependencies({required Widget child, LayerLink? link}) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MessageOverlayCubit>(
            create: (_) => mockMessageOverlayCubit,
          ),
          BlocProvider(
            create: (_) => UserCubit(fakeUser),
          ),
          BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
        ],
        child: Column(
          children: [
            if (link != null) CompositedTransformTarget(link: link),
            child,
          ],
        ));
  }

  setUp(() {
    registerAllMockServices();

    when(() => mockMessageOverlayCubit.scrollController)
        .thenReturn(ScrollController());
  });

  testWidgets('should render child', (tester) async {
    const lookupKey = Key('findMe');

    whenListen(
        mockMessageOverlayCubit, const Stream<MessageOverlayState>.empty(),
        initialState: MessageOverlayState.none());

    await tester.pumpApp(wrapWithDependencies(
        child: MessageOverlayDisplay(
            child: Container(
      key: lookupKey,
    ))));

    expect(find.byKey(lookupKey), findsOneWidget);
  });

  testWidgets('should not display overlay on none', (tester) async {
    whenListen(
        mockMessageOverlayCubit, const Stream<MessageOverlayState>.empty(),
        initialState: MessageOverlayState.none());

    await tester.pumpApp(
        wrapWithDependencies(child: MessageOverlayDisplay(child: Container())));
    await tester.pump();

    expect(find.byType(MessageReactionOverlay), findsNothing);
    expect(find.byType(MessageOptionsOverlay), findsNothing);
  });

  testWidgets('should display reaction on reaction', (tester) async {
    final layerLink = LayerLink();

    whenListen(
        mockMessageOverlayCubit,
        Stream<MessageOverlayState>.fromIterable([
          MessageOverlayState.reactions(
              layerLink: layerLink, message: fakeMessage)
        ]),
        initialState: MessageOverlayState.none());

    await tester.pumpApp(
        wrapWithDependencies(child: MessageOverlayDisplay(child: Container())));
    await tester.pump();

    expect(find.byType(MessageReactionOverlay), findsOneWidget);
  });

  testWidgets('should display settings on settings', (tester) async {
    final layerLink = LayerLink();

    whenListen(
        mockMessageOverlayCubit,
        Stream<MessageOverlayState>.fromIterable([
          MessageOverlayState.settings(
              layerLink: layerLink, message: fakeMessage)
        ]),
        initialState: MessageOverlayState.none());

    await tester.pumpApp(
        wrapWithDependencies(child: MessageOverlayDisplay(child: Container())));
    await tester.pump();

    expect(find.byType(MessageOptionsOverlay), findsOneWidget);
  });

  testWidgets('should dismiss reaction overlay on double taps', (tester) async {
    final layerLink = LayerLink();

    final streamController = stubBlocStream<MessageOverlayState>(
        mockMessageOverlayCubit,
        initialState: MessageOverlayState.none());

    await tester.pumpApp(
        wrapWithDependencies(child: MessageOverlayDisplay(child: Container())));

    streamController.add(MessageOverlayState.reactions(
        layerLink: layerLink, message: fakeMessage));
    await tester.pump();

    expect(find.byType(MessageReactionOverlay), findsOneWidget);

    streamController.add(MessageOverlayState.reactions(
        layerLink: layerLink, message: fakeMessage));
    await tester.pump();

    expect(find.byType(MessageReactionOverlay), findsNothing);
  });
}
