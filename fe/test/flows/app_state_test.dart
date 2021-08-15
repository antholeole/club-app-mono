import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/view/login_page.dart';
import 'package:fe/pages/main/view/main_page.dart';
import 'package:fe/pages/splash/view/splash_page.dart';
import 'package:fe/service_locator.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_helpers/fixtures/user.dart';
import '../test_helpers/get_it_helpers.dart';
import '../test_helpers/pump_app.dart';

void main() {
  group('app flow', () {
    setUpAll(() {
      getIt.allowReassignment = true;

      registerAllServices();
    });

    testWidgets('should default to splash screen', (tester) async {
      getIt.registerSingleton(FlowController(AppState.loading()));

      await tester.pumpApp(const Builder(builder: AppState.getFlow));

      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets('should navigate to main page when logged in addded',
        (tester) async {
      final flowController = FlowController(AppState.loading());
      getIt.registerSingleton(flowController);

      await tester.pumpApp(const Builder(builder: AppState.getFlow));
      flowController.update((_) => AppState.loggedIn(mockUser));
      await tester.pump(const Duration(milliseconds: 5));

      await expectLater(find.byType(MainPage), findsOneWidget);
    });

    testWidgets('should navigate to login page when not logged in',
        (tester) async {
      final flowController = FlowController(AppState.loading());
      getIt.registerSingleton(flowController);

      await tester.pumpApp(const Builder(builder: AppState.getFlow));
      flowController.update((_) => AppState.needLogIn());
      await tester.pumpAndSettle();

      await expectLater(find.byType(LoginPage), findsOneWidget);
    });
  });
}
