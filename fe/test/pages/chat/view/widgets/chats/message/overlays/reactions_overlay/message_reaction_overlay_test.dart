import 'package:clock/clock.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/message_reaction_overlay.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/reaction_display.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../../test_helpers/pump_app.dart';
import '../../../../../../../../test_helpers/stub_gql_response.dart';
import 'package:fe/gql/upsert_reaction.var.gql.dart';
import 'package:fe/gql/upsert_reaction.data.gql.dart';

void main() {
  setUp(() async {
    await registerAllMockServices();
  });

  testWidgets('should dissmiss self on reacted', (tester) async {
    stubGqlResponse<GUpsertReactionData, GUpsertReactionVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GUpsertReactionData.fromJson({})!);

    final caller = MockCaller();

    await tester.pumpApp(MessageReactionOverlay(
        link: LayerLink(),
        message: Message(
            createdAt: clock.now(),
            id: UuidType.generate(),
            isImage: false,
            message: 'asdasd',
            updatedAt: clock.now(),
            user: User(id: UuidType.generate(), name: 'asdas'),
            reactions: {}),
        selfId: UuidType.generate(),
        dismissSelf: caller.call,
        scrollController: ScrollController()));

    await tester.tap(find.byType(ReactionDisplay).first);
    await tester.pumpAndSettle();

    verify(() => caller.call()).called(1);
  });

  testWidgets('should dissmiss on scroll', (tester) async {
    final scrollController = ScrollController();
    const listKey = ValueKey('blaoisdjasoidj');

    final mockCaller = MockCaller();

    await tester.pumpApp(SizedBox(
      width: 400,
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              key: listKey,
              itemBuilder: (ctx, i) => Text(i.toString()),
              controller: scrollController,
            ),
          ),
          MessageReactionOverlay(
              link: LayerLink(),
              message: Message(
                  createdAt: clock.now(),
                  id: UuidType.generate(),
                  isImage: false,
                  message: 'asdasd',
                  updatedAt: clock.now(),
                  user: User(id: UuidType.generate(), name: 'asdas'),
                  reactions: {}),
              selfId: UuidType.generate(),
              dismissSelf: mockCaller.call,
              scrollController: scrollController),
        ],
      ),
    ));

    await tester.drag(
      find.byKey(listKey), // widget you want to scroll
      const Offset(0, -100), // delta to move
    );

    verify(() => mockCaller.call()).called(greaterThan(1));
  });

  //should dismiss on LinkLeader unlinked and scroll
}
