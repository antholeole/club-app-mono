import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/login_page.dart';
import 'package:fe/pages/login/view/widgets/sign_in_with_provider_button.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';

void main() {
  setUpAll(() async {
    await registerAllServices(needCubitAutoEvents: true);
  });

  group('login page', () {
    testWidgets('should render login view', (tester) async {
      await tester.pumpApp(LoginPage());
      await tester.pumpAndSettle();

      expect(find.byType(LoginView), findsOneWidget);
    });
  });

  group('login view', () {
    const failureMessage = 'failureMessage';

    MockLoginCubit mockLoginCubit = MockLoginCubit.getMock();
    MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

    Widget wrapWithWidgets(Widget child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
          BlocProvider<LoginCubit>(
            create: (context) => mockLoginCubit,
          ),
        ],
        child: child,
      );
    }

    setUp(() {
      resetMockCubit(mockLoginCubit);
    });

    testWidgets('should render login buttons on inital', (tester) async {
      whenListen(mockLoginCubit, Stream<LoginState>.fromIterable([]),
          initialState: LoginState.initial());

      await tester.pumpApp(wrapWithWidgets(LoginView()));
      await tester.pumpAndSettle();

      expect(find.byType(SignInWithProviderButton), findsNWidgets(1));
    });

    testWidgets('should render loader on loading', (tester) async {
      whenListen(mockLoginCubit, Stream<LoginState>.fromIterable([]),
          initialState: LoginState.loading());

      await tester.pumpApp(wrapWithWidgets(LoginView()));
      await tester.pump();

      expect(find.byType(Loader), findsNWidgets(1));
    });

    testWidgets('should render login buttons and toast on failure',
        (tester) async {
      whenListen(
          mockLoginCubit,
          Stream<LoginState>.fromIterable([
            LoginState.failure(const Failure(
                status: FailureStatus.Unknown, message: failureMessage))
          ]),
          initialState: LoginState.loading());

      await tester.pumpApp(wrapWithWidgets(LoginView()));
      await tester.pump();

      expect(find.byType(SignInWithProviderButton), findsNWidgets(1));

      verify(() => mockToasterCubit.add(any(
          that: isA<Toast>().having(
              (toast) => toast.type, 'type', ToastType.Error)))).called(1);
    });

    testWidgets('should push new window on login success', (tester) async {
      const loggedInKey = Key('logged-in');
      final loggedInUser = User(name: 'adsad', id: UuidType.generate());

      User? appStateUser;

      whenListen(mockLoginCubit,
          Stream<LoginState>.fromIterable([LoginState.success(loggedInUser)]),
          initialState: LoginState.loading());

      await tester.pumpApp(FlowBuilder<AppState>(
          state: AppState.needLogIn(),
          onGeneratePages: (state, __) {
            return [
              MaterialPage(
                  child: state.join((_) => Container(), (loggedIn) {
                appStateUser = loggedIn.user; //assign user here
                return Container(
                  key: loggedInKey,
                );
              }, (_) => wrapWithWidgets(LoginView())))
            ];
          }));

      expect(appStateUser, equals(loggedInUser));
    });
  });
}
