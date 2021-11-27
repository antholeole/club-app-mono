import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/hold_overlay/message_options_overlay.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../test_helpers/mocks.dart';
import '../../../../../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('clicking on the copy option should copy to clipboard',
      (tester) async {
    SystemChannels.platform
        .setMockMethodCallHandler((MethodCall methodCall) async {});

    final MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

    await tester.pumpApp(BlocProvider<ToasterCubit>(
      create: (_) => mockToasterCubit,
      child: MessageOptionsOverlay(
          dismissSelf: () {},
          link: LayerLink(),
          message: Message(
              createdAt: clock.now(),
              id: UuidType.generate(),
              isImage: false,
              message: 'asdas',
              updatedAt: clock.now(),
              user: User(id: UuidType.generate(), name: 'asdsa'),
              reactions: {})),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.copy));

    verify(() => mockToasterCubit.add(any(
        that: isA<Toast>()
            .having((toast) => toast.type, 'toast type', ToastType.Success))));
  });
}
