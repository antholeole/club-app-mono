import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/splash/cubit/splash_cubit.dart';
import 'package:fe/pages/splash/view/splash_page.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/mocks.dart';
import '../../../test_helpers/pump_app.dart';

void main() {
  final User fakeUser = User(id: UuidType.generate(), name: 'Loons');

  late MockSplashCubit mockSplashCubit;

  setUp(() {
    mockSplashCubit = MockSplashCubit.getMock();
  });

  group('SplashView', () {
    testWidgets('should add loggedInState(user) when finds user',
        (tester) async {
      whenListen(
        mockSplashCubit,
        Stream.fromIterable(
            [SplashState.initial(), SplashState.loggedIn(fakeUser)]),
        initialState: SplashState.initial(),
      );

      bool loggedInState = false;

      await tester.pumpApp(BlocProvider<SplashCubit>(
        create: (context) => mockSplashCubit,
        child: FlowBuilder<AppState>(
          state: AppState.loading(),
          onGeneratePages: (state, pages) {
            state.join((_) => null, (_) => loggedInState = true, (_) => null);
            return [MaterialPage(child: SplashView())];
          },
        ),
      ));

      await expectLater(loggedInState, true,
          reason: 'should have added login state');
    });
    testWidgets(
      'should add notLoggedInState to app state flow builder',
      (tester) async {
        whenListen(
          mockSplashCubit,
          Stream.fromIterable(
              [SplashState.initial(), SplashState.notLoggedIn()]),
          initialState: SplashState.initial(),
        );

        bool notLoggedInState = false;

        await tester.pumpApp(BlocProvider<SplashCubit>(
          create: (context) => mockSplashCubit,
          child: FlowBuilder<AppState>(
            state: AppState.loading(),
            onGeneratePages: (state, pages) {
              state.join(
                  (_) => null, (_) => null, (_) => notLoggedInState = true);
              return [MaterialPage(child: SplashView())];
            },
          ),
        ));

        await expectLater(notLoggedInState, true,
            reason: 'should have added not login state');
      },
    );
  });
}
