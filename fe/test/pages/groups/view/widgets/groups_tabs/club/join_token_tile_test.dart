import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/join_token_tile.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';

import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/upsert_group_join_token.data.gql.dart';
import 'package:fe/gql/upsert_group_join_token.var.gql.dart';
import 'package:fe/gql/upsert_group_join_token.req.gql.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../test_helpers/pump_app.dart';
import '../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final GroupReqCubit mockGroupReqCubit = MockGroupReqCubit.getMock();

  Club getClub({String? withJoinToken}) {
    return Club(
        id: UuidType.generate(),
        name: 'blah',
        admin: true,
        joinToken: withJoinToken);
  }

  Widget build({required Widget child, required Club club}) {
    return BlocProvider<GroupReqCubit>(
      create: (context) => mockGroupReqCubit,
      child: Provider<Club>(
        create: (_) => club,
        child: child,
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(GUpsertGroupJoinTokenData.fromJson({})!);
  });

  setUp(() {
    registerAllMockServices();
  });

  testWidgets('should display no join token on no join token', (tester) async {
    await tester.pumpApp(build(child: JoinTokenTile(), club: getClub()));

    expect(find.text(JoinTokenTile.NO_JOIN_TOKEN_TEXT), findsOneWidget);
  });

  testWidgets('should display join token on join token', (tester) async {
    const joinToken = 'IM A HAPPYL ITTLE JOIN TOKEN';

    await tester.pumpApp(
        build(child: JoinTokenTile(), club: getClub(withJoinToken: joinToken)));

    expect(find.text(joinToken), findsOneWidget);
  });

  testWidgets('should call delete on delete', (tester) async {
    const joinToken = 'IM A HAPPYL ITTLE JOIN TOKEN';

    stubGqlResponse<GUpsertGroupJoinTokenData, GUpsertGroupJoinTokenVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GUpsertGroupJoinTokenData.fromJson({})!);

    await tester.pumpApp(
        build(child: JoinTokenTile(), club: getClub(withJoinToken: joinToken)));
    await tester.tap(find.byIcon(Icons.delete));

    final req = verify(() => getIt<AuthGqlClient>().request(captureAny()))
        .captured
        .first as GUpsertGroupJoinTokenReq;

    expect(req.vars.new_token, null);
  });

  testWidgets('should call refresh on refresh', (tester) async {
    const joinToken = 'IM A HAPPYL ITTLE JOIN TOKEN';

    stubGqlResponse<GUpsertGroupJoinTokenData, GUpsertGroupJoinTokenVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GUpsertGroupJoinTokenData.fromJson({})!);

    await tester.pumpApp(
        build(child: JoinTokenTile(), club: getClub(withJoinToken: joinToken)));
    await tester.tap(find.byIcon(Icons.refresh));

    final req = verify(() => getIt<AuthGqlClient>().request(captureAny()))
        .captured
        .first as GUpsertGroupJoinTokenReq;

    expect(req.vars.new_token, isNot(null));
  });

  testWidgets('should call handle failure on failure', (tester) async {
    const joinToken = 'IM A HAPPYL ITTLE JOIN TOKEN';

    stubGqlResponse<GUpsertGroupJoinTokenData, GUpsertGroupJoinTokenVars>(
        getIt<AuthGqlClient>(),
        error: (_) => Failure(status: FailureStatus.GQLMisc));

    await tester.pumpApp(
        build(child: JoinTokenTile(), club: getClub(withJoinToken: joinToken)));
    await tester.tap(find.byIcon(Icons.refresh));

    verify(() => getIt<Handler>().handleFailure(any(), any())).called(1);
  });
}
