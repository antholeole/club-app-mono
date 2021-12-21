import 'package:fe/pages/main/view/widgets/group_joiner.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import '../../../../test_helpers/get_it_helpers.dart';
import '../../../../test_helpers/pump_app.dart';
import 'package:fe/gql/join_roles_with_join_codes.req.gql.dart';

void main() {
  const promptShowerKey = ValueKey('prompt shower key');

  final promptShower = Builder(
      builder: (context) => FloatingActionButton(
          key: promptShowerKey,
          onPressed: context.read<GroupJoiner>().showPrompt,
          child: const Text('im a fab')));

  Future<void> showPrompt(WidgetTester tester) async {
    await tester.tap(find.byKey(promptShowerKey));
    await tester.pumpAndSettle();
  }

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return child;
  }

  testWidgets('should show prompt on show prompt', (tester) async {
    await tester.pumpApp(
        wrapWithDependencies(child: GroupJoinDisplay(child: promptShower)));
    await showPrompt(tester);
    expect(find.text(GroupJoinDisplay.JOIN_GROUP_PROMPT_COPY), findsOneWidget);
  });

  testWidgets('should not call API on cancel', (tester) async {
    await tester.pumpApp(
        wrapWithDependencies(child: GroupJoinDisplay(child: promptShower)));

    await showPrompt(tester);
    await tester.tap(find.text(GroupJoinDisplay.CANCEL_JOIN_GROUP_BUTTON_COPY));
    await tester.pumpAndSettle();
    expect(find.text(GroupJoinDisplay.JOIN_GROUP_PROMPT_COPY), findsNothing);

    verifyNever(() => getIt<AuthGqlClient>().mutateFromUi(any(), any(),
        errorMessage: any(named: 'errorMessage'),
        successMessage: any(named: 'successMessage')));
  });

  testWidgets('should call mutate API on submit', (tester) async {
    final joinCodes = ['asdasd', '34234', 'GAOSKDOASKD'];

    when(() => getIt<AuthGqlClient>().mutateFromUi(
        any(
            that: isA<GJoinRolesWithJoinCodesReq>().having(
                (req) => req.vars.join_codes, 'join codes', equals(joinCodes))),
        any(),
        errorMessage: any(named: 'errorMessage'),
        successMessage:
            any(named: 'successMessage'))).thenAnswer((_) async => null);

    await tester.pumpApp(
        wrapWithDependencies(child: GroupJoinDisplay(child: promptShower)));
    await showPrompt(tester);
    await tester.enterText(find.byType(PlatformTextField), joinCodes.join('+'));
    await tester.tap(find.text(GroupJoinDisplay.JOIN_GROUP_BUTTON_COPY));
    await tester.pumpAndSettle();

    verify(() => getIt<AuthGqlClient>().mutateFromUi(
        any(
            that: isA<GJoinRolesWithJoinCodesReq>().having(
                (req) => req.vars.join_codes, 'join codes', equals(joinCodes))),
        any(),
        errorMessage: any(named: 'errorMessage'),
        successMessage: any(named: 'successMessage'))).called(1);
  });
}
