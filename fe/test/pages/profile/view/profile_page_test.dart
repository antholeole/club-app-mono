import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/cubit/name_change_cubit.dart';
import 'package:fe/pages/profile/view/profile_page.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';

void main() {
  final fakeUser = User(name: 'han', id: UuidType.generate());

  final mockMainCubit = MockMainCubit.getMock();

  setUp(() {
    registerAllMockServices();
  });

  group('profile page', () {
    testWidgets('should render profile view', (tester) async {
      await tester.pumpApp(MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(create: (_) => UserCubit(fakeUser)),
          BlocProvider<MainCubit>(
            create: (context) => mockMainCubit,
          ),
        ],
        child: ProfilePage(),
      ));

      expect(find.byType(ProfileView), findsOneWidget);
    });
  });

  group('profile view', () {
    final mockNameChangeCubit = MockNameChangeCubit.getMock();
    final mockToasterCubit = MockToasterCubit.getMock();

    Widget wrapWithDependencies(Widget child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(
            create: (_) => mockMainCubit,
          ),
          BlocProvider<NameChangeCubit>(create: (_) => mockNameChangeCubit),
          BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
          BlocProvider<UserCubit>(create: (_) => UserCubit(fakeUser)),
        ],
        child: child,
      );
    }

    setUp(() {
      <MockCubit>[mockNameChangeCubit, mockToasterCubit].forEach(resetMockBloc);
    });

    testWidgets('should display users name', (tester) async {
      whenListen(mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
          initialState: NameChangeState.notChanging());

      await tester.pumpApp(wrapWithDependencies(ProfileView()));

      expect(find.text(fakeUser.name), findsOneWidget);
    });

    group('name change', () {
      const fakeName = 'asdasda';

      testWidgets('should call nameChangeCubit.changeName on button press',
          (tester) async {
        whenListen(
            mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
            initialState: NameChangeState.notChanging());

        when(() => mockNameChangeCubit.changeName(fakeName, any()))
            .thenAnswer((_) async => null);

        await tester.pumpApp(wrapWithDependencies(ProfileView()));

        await tester.tap(find.text(ProfileView.CHANGE_NAME_COPY));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(PlatformTextField), fakeName);
        await tester.tap(find.text(ProfileView.UPDATE_NAME_BUTTON_COPY));
        await tester.pumpAndSettle();

        verify(() => mockNameChangeCubit.changeName(fakeName, any()));
      });

      testWidgets('should build loader on name changing', (tester) async {
        whenListen(
            mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
            initialState: NameChangeState.changing());

        await tester.pumpApp(wrapWithDependencies(ProfileView()));

        expect(
            tester
                .firstWidget<LoadableTileButton>(
                    find.byType(LoadableTileButton))
                .loading,
            true);
      });

      testWidgets('should not call any events if name submit canceled',
          (tester) async {
        whenListen(
            mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
            initialState: NameChangeState.notChanging());

        await tester.pumpApp(wrapWithDependencies(ProfileView()));
        await tester.tap(find.text(ProfileView.CHANGE_NAME_COPY));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(PlatformTextField), fakeName);
        await tester.tap(find.text(ProfileView.CANCEL_NAME_CHANGE_COPY));
        await tester.pumpAndSettle();

        verifyNever(() => mockNameChangeCubit.changeName(any(), any()));
      });

      testWidgets(
          'should handle failure and build name change button on failure',
          (tester) async {
        whenListen(
            mockNameChangeCubit,
            Stream<NameChangeState>.fromIterable([
              NameChangeState.failure(Failure(status: FailureStatus.GQLMisc))
            ]),
            initialState: NameChangeState.notChanging());

        await tester.pumpApp(wrapWithDependencies(ProfileView()));

        verify(() => getIt<Handler>().handleFailure(any(), any(),
            withPrefix: any(named: 'withPrefix'))).called(1);
        expect(find.text(ProfileView.CHANGE_NAME_COPY), findsOneWidget);
      });

      testWidgets('should toast on successful name update', (tester) async {
        whenListen(
            mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
            initialState: NameChangeState.notChanging());

        whenListen(mockToasterCubit, Stream<ToasterState>.fromIterable([]),
            initialState: ToasterState());

        when(() => mockNameChangeCubit.changeName(fakeName, any()))
            .thenAnswer((invocation) async {
          (invocation.positionalArguments[1] as VoidCallback)();
        });

        when(() => getIt<LocalUserService>().getLoggedInUser())
            .thenAnswer((_) async => fakeUser);

        await tester.pumpApp(wrapWithDependencies(ProfileView()));
        await tester.tap(find.text(ProfileView.CHANGE_NAME_COPY));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(PlatformTextField), fakeName);
        await tester.tap(find.text(ProfileView.UPDATE_NAME_BUTTON_COPY));
        await tester.pumpAndSettle();

        verify(() => mockToasterCubit.add(any(
            that: isA<Toast>()
                .having((toast) => toast.type, 'type', ToastType.Success))));
      });
    });

    group('log out', () {
      setUp(() {
        whenListen(
            mockNameChangeCubit, Stream<NameChangeState>.fromIterable([]),
            initialState: NameChangeState.notChanging());
      });
      testWidgets('should call logout on logout click', (tester) async {
        when(() => mockMainCubit.logOut(withError: any(named: 'withError')))
            .thenAnswer((_) async => null);

        await tester.pumpApp(wrapWithDependencies(ProfileView()));
        await tester.tap(find.text(ProfileView.LOGOUT_COPY));

        verify(() => mockMainCubit.logOut(
            withError: any(named: 'withError', that: isNull))).called(1);
      });
    });
  });
}
