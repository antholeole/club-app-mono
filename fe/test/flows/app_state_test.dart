import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/view/login_page.dart';
import 'package:fe/pages/main/view/main_page.dart';
import 'package:fe/pages/splash/view/splash_page.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/image_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/gql/query_self_group_preview.var.gql.dart';
import '../test_helpers/get_it_helpers.dart';
import '../test_helpers/pump_app.dart';
import '../test_helpers/stub_gql_response.dart';

void main() {
  group('app flow', () {
    final fakeUser = User(id: UuidType.generate(), name: 'a thony');

    setUpAll(() {
      getIt.allowReassignment = true;

      registerAllMockServices();

      when(() => getIt<LocalFileStore>().deserialize(any()))
          .thenAnswer((_) async => null);
      when(() => getIt<ImageHandler>().preCache(any()))
          .thenAnswer((_) async => null);
    });

    testWidgets('should default to splash screen', (tester) async {
      getIt.registerSingleton(FlowController(AppState.loading()));

      await tester.pumpApp(const Builder(builder: AppState.getFlow));

      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets('should navigate to main page when logged in addded',
        (tester) async {
      when(() => getIt<LocalUserService>().getLoggedInUserId())
          .thenAnswer((_) async => UuidType.generate());
      stubGqlResponse<GQuerySelfGroupsPreviewData, GQuerySelfGroupsPreviewVars>(
          getIt<AuthGqlClient>(),
          data: (_) => GQuerySelfGroupsPreviewData.fromJson({})!);

      final flowController = FlowController(AppState.loading());
      getIt.registerSingleton(flowController);

      await tester.pumpApp(const Builder(builder: AppState.getFlow));
      flowController.update((_) => AppState.loggedIn(fakeUser));
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
