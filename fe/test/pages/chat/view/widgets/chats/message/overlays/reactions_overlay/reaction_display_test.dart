import 'package:badges/badges.dart';
import 'package:fe/data/models/reaction.dart';
import 'package:fe/pages/chat/view/widgets/chats/message/overlays/reactions_overlay/reaction_display.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/upsert_reaction.var.gql.dart';
import 'package:fe/gql/upsert_reaction.req.gql.dart';
import 'package:fe/gql/upsert_reaction.data.gql.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../../test_helpers/pump_app.dart';
import '../../../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  setUp(() async {
    await registerAllMockServices();
  });

  testWidgets('should show badge based on reaction count', (tester) async {
    const reactionCount = 3;

    await tester.pumpApp(Column(
      children: [
        ReactionDisplay(
            reactionType: ReactionType.Cry,
            reactionCount: reactionCount,
            selfReacted: false,
            messageId: UuidType.generate(),
            userId: UuidType.generate(),
            onReacted: (_, __) {})
      ],
    ));
    expect(
        ((find.byType(Badge).evaluate().first.widget as Badge).badgeContent
                as Text)
            .data,
        reactionCount.toString());
  });
  group('reaction api call', () {
    testWidgets('should call with deleted = true if already reacted',
        (tester) async {
      late Invocation invocation;
      stubGqlResponse<GUpsertReactionData, GUpsertReactionVars>(
          getIt<AuthGqlClient>(), data: (invoc) {
        invocation = invoc;
        return GUpsertReactionData.fromJson({})!;
      });

      await tester.pumpApp(Column(
        children: [
          ReactionDisplay(
              reactionType: ReactionType.Cry,
              reactionCount: 3,
              selfReacted: true,
              messageId: UuidType.generate(),
              userId: UuidType.generate(),
              onReacted: (_, __) {})
        ],
      ));

      await tester.tap(find.byType(ReactionDisplay));

      expect(
          (invocation.positionalArguments[0] as GUpsertReactionReq)
              .vars
              .deleted,
          true);

      await tester.pumpAndSettle();
    });

    testWidgets('should call with deleted = false if not already reacted',
        (tester) async {
      late Invocation invocation;
      stubGqlResponse<GUpsertReactionData, GUpsertReactionVars>(
          getIt<AuthGqlClient>(), data: (invoc) {
        invocation = invoc;
        return GUpsertReactionData.fromJson({})!;
      });

      await tester.pumpApp(Column(
        children: [
          ReactionDisplay(
              reactionType: ReactionType.Cry,
              reactionCount: 3,
              selfReacted: false,
              messageId: UuidType.generate(),
              userId: UuidType.generate(),
              onReacted: (_, __) {})
        ],
      ));

      await tester.tap(find.byType(ReactionDisplay));

      expect(
          (invocation.positionalArguments[0] as GUpsertReactionReq)
              .vars
              .deleted,
          false);

      await tester.pumpAndSettle();
    });

    testWidgets('should call handler on failure', (tester) async {
      stubGqlResponse<GUpsertReactionData, GUpsertReactionVars>(
          getIt<AuthGqlClient>(),
          error: (_) => Failure(status: FailureStatus.GQLMisc));

      await tester.pumpApp(Column(
        children: [
          ReactionDisplay(
              reactionType: ReactionType.Cry,
              reactionCount: 3,
              selfReacted: true,
              messageId: UuidType.generate(),
              userId: UuidType.generate(),
              onReacted: (_, __) {})
        ],
      ));

      await tester.tap(find.byType(ReactionDisplay));

      verify(() => getIt<Handler>().handleFailure(any(), any(),
          withPrefix: any(named: 'withPrefix'))).called(1);

      await tester.pumpAndSettle();
    });
  });
}
