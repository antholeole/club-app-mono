import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/view/main_page.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart' as sc;
import 'package:fe/service_locator.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/stub_cubit_stream.dart';

void main() {
  final fakeUser = User(name: 'mock user', id: UuidType.generate());
  final fakeGroup =
      Club(id: UuidType.generate(), name: 'my group', admin: false);
  const failureMessage = 'failurefailure';

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(Failure(status: FailureStatus.GQLMisc));
  });

  setUp(() async {
    await registerAllMockServices();
  });

  group('main page', () {
    testWidgets('should render main view', (tester) async {
      await tester.pumpApp(MainPage(user: fakeUser));

      expect(find.byType(MainView), findsOneWidget);
    });
  });

  group('main view', () {
    final mockPageCubit = MockPageCubit.getMock();
    final mockMainCubit = MockMainCubit.getMock();
    final mockToasterCubit = MockToasterCubit.getMock();
    final mockScaffoldCubit = MockScaffoldCubit.getMock();

    final fakeFailure = Failure(status: FailureStatus.GQLMisc);

    Widget wrapWithDependencies(Widget child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(
            create: (context) => mockMainCubit,
          ),
          BlocProvider<PageCubit>(
            create: (context) => mockPageCubit,
          ),
          BlocProvider<ToasterCubit>(
            create: (context) => mockToasterCubit,
          ),
          BlocProvider<sc.ScaffoldCubit>(
            create: (context) => mockScaffoldCubit,
          ),
        ],
        child: child,
      );
    }

    testWidgets('should handle failure on main page load failure',
        (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());
      whenListen(mockMainCubit,
          Stream<MainState>.fromIterable([MainState.loadFailure(fakeFailure)]),
          initialState: MainState.groupless());
      whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
          initialState: const sc.ScaffoldInitial());

      await tester.pumpApp(wrapWithDependencies(MainView()));

      verify(() => getIt<Handler>().handleFailure(any(), any(),
          toast: any(named: 'toast'),
          withPrefix: any(named: 'withPrefix'))).called(1);
    });

    testWidgets('should show retry button on need to retry', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());
      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.loadFailure(fakeFailure));
      whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
          initialState: const sc.ScaffoldInitial());
      when(() => mockMainCubit.initalizeMainPage())
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(MainView()));
      await tester.tap(find.byType(PillButton));

      verify(() => mockMainCubit.initalizeMainPage()).called(1);
    });

    testWidgets('should show groupless copy on no group', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());
      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.groupless());
      whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
          initialState: const sc.ScaffoldInitial());

      await tester.pumpApp(wrapWithDependencies(MainView()));
      expect(find.text(MainView.GROUPLESS_COPY), findsOneWidget);
    });

    testWidgets('should render page view if load with groups', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());
      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.withClub(fakeGroup));
      whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
          initialState: const sc.ScaffoldInitial());

      when(() => getIt<SharedPreferences>().remove(any()))
          .thenAnswer((_) async => false);

      await tester.pumpApp(wrapWithDependencies(MainView()));
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('should show spinner when spinning', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());
      whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
          initialState: MainState.loading());
      whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
          initialState: const sc.ScaffoldInitial());

      await tester.pumpApp(wrapWithDependencies(MainView()));
      expect(find.byType(Loader), findsOneWidget);
    });

    group('log out', () {
      testWidgets('should toast with error if logged out due to error',
          (tester) async {
        const loggedOutKey = Key('imloggedout');
        final mockMainCubitStream =
            stubBlocStream(mockMainCubit, initialState: MainState.loading());

        whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
            initialState: PageState.eventPage());
        whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
            initialState: const sc.ScaffoldInitial());

        await tester.pumpApp(FlowBuilder<AppState>(
            state: AppState.loggedIn(fakeUser),
            onGeneratePages: (state, _) => [
                  MaterialPage(
                      child: state.join(
                          (_) => Container(),
                          (_) => wrapWithDependencies(MainView()),
                          (_) => Container(
                                key: loggedOutKey,
                              )))
                ]));

        mockMainCubitStream.add(MainState.logOut(withError: failureMessage));
        await tester.pump();

        expect(find.byKey(loggedOutKey), findsOneWidget);
        verify(() => mockToasterCubit.add(any(
            that: isA<Toast>().having((toast) => toast.message,
                'message has failure message', contains(failureMessage)))));
      });

      testWidgets('should toast with error if logged out due to error',
          (tester) async {
        const loggedOutKey = Key('imloggedout');
        final mockMainCubitStream =
            stubBlocStream(mockMainCubit, initialState: MainState.loading());

        whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
            initialState: PageState.eventPage());
        whenListen(mockScaffoldCubit, Stream<sc.ScaffoldState>.fromIterable([]),
            initialState: const sc.ScaffoldInitial());

        await tester.pumpApp(FlowBuilder<AppState>(
            state: AppState.loggedIn(fakeUser),
            onGeneratePages: (state, _) => [
                  MaterialPage(
                      child: state.join(
                          (_) => Container(),
                          (_) => wrapWithDependencies(MainView()),
                          (_) => Container(
                                key: loggedOutKey,
                              )))
                ]));

        mockMainCubitStream.add(MainState.logOut());
        await tester.pump();

        expect(find.byKey(loggedOutKey), findsOneWidget);
        verify(() => mockToasterCubit.add(any(
            that: isA<Toast>().having(
                (toast) => toast.message,
                'message has failure message',
                contains(MainView.LOGOUT_COPY)))));
      });
    });
  });
}
