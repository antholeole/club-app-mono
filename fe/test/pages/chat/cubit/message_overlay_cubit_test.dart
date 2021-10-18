import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/message_overlay_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';

void main() {
  final fakeLayerLink = LayerLink();
  final fakeMessage = Message(
      user: User(id: UuidType.generate(), name: 'asdsa'),
      id: UuidType.generate(),
      message: 'asdsa',
      isImage: false,
      createdAt: clock.now(),
      updatedAt: clock.now());

  blocTest<MessageOverlayCubit, MessageOverlayState>(
      'should emit settings on add settings',
      build: () =>
          MessageOverlayCubit(scrollController: MockScrollController()),
      act: (cubit) => cubit.addSettingsOverlay(
          layerLink: fakeLayerLink, message: fakeMessage),
      expect: () => [
            isA<MessageOverlayState>().having(
                (state) => state.join((_) => null, (mos) => mos, (_) => null),
                'state',
                isNotNull)
          ]);

  blocTest<MessageOverlayCubit, MessageOverlayState>(
      'should emit reaction on add reaction',
      build: () =>
          MessageOverlayCubit(scrollController: MockScrollController()),
      act: (cubit) => cubit.addReactionOverlay(
          layerLink: fakeLayerLink, message: fakeMessage),
      expect: () => [
            isA<MessageOverlayState>().having(
                (state) => state.join((n) => null, (_) => null, (mor) => mor),
                'state',
                isNotNull)
          ]);

  final MockScrollController mockScrollController = MockScrollController();
  blocTest<MessageOverlayCubit, MessageOverlayState>(
      'should emit reaction on add reaction',
      build: () => MessageOverlayCubit(scrollController: mockScrollController),
      act: (cubit) => cubit.close(),
      verify: (_) =>
          verify(() => mockScrollController.dispose()).called(greaterThan(1)));

  //close should close scroll controller
}
