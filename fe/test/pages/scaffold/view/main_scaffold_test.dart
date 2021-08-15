import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fe/config.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/scaffold/cubit/data_carriers/main_scaffold_parts.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart' as sc;
import 'package:fe/pages/scaffold/view/main_scaffold.dart';
import 'package:fe/pages/scaffold/view/widgets/drawers/left_drawer/club_drawer.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../test_helpers/cubit_patch_close.dart';
import '../../../test_helpers/fixtures/group.dart';
import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/pump_app.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/stub_cubit_stream.dart';
import '../../../test_helpers/testing_config.dart';

void main() {
  MockScaffoldCubit mockScaffoldCubit = MockScaffoldCubit.getMock();
  MockMainCubit mockMainCubit = MockMainCubit.getMock();
  MockWsClient mockWsClient = MockWsClient.getMock();
  MockPageCubit mockPageCubit = MockPageCubit.getMock();

  Widget wrapWithDependencies(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageCubit>(
          create: (_) => mockPageCubit,
        ),
        BlocProvider<MainCubit>(
          create: (_) => mockMainCubit,
        ),
        BlocProvider<sc.ScaffoldCubit>(
          create: (_) => mockScaffoldCubit,
        ),
      ],
      child: child,
    );
  }

  setUpAll(() {
    getIt.registerSingleton<WsClient>(mockWsClient);
  });

  setUp(() async {
    <MockCubit>[mockPageCubit, mockMainCubit, mockScaffoldCubit]
        .forEach((cubit) {
      reset(cubit);
      patchCubitClose(cubit);
    });

    reset(mockWsClient);
    mockWsClient.emptyStub();

    whenListen(mockMainCubit, Stream<MainState>.fromIterable([]),
        initialState: MainState.withGroup(mockGroupNotAdmin));

    whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
        initialState: PageState.eventPage());
  });

  testWidgets('should render main scaffold', (tester) async {
    whenListen(
        mockScaffoldCubit, Stream.fromIterable([const sc.ScaffoldInitial()]),
        initialState: const sc.ScaffoldInitial());

    await tester
        .pumpApp(wrapWithDependencies(MainScaffold(child: Container())));

    expect(find.byType(MainScaffold), findsOneWidget);
  });

  group('scaffold', () {
    setUp(() {
      whenListen(
        mockScaffoldCubit,
        Stream<sc.ScaffoldState>.fromIterable([]),
        initialState: const sc.ScaffoldInitial(),
      );
    });

    testWidgets('click on bottom nav should update page cubit', (tester) async {
      await tester
          .pumpApp(wrapWithDependencies(MainScaffold(child: Container())));
    });
  });

  group('scaffoldState', () {
    testWidgets('drawer should open on click', (tester) async {
      final mockConfig = TestingConfig();
      final mockLocalUserService = MockLocalUserService();
      final mockGqlClient = MockGqlClient.getMock();

      getIt.registerSingleton<LocalUserService>(mockLocalUserService);
      getIt.registerSingleton<Client>(mockGqlClient);
      getIt.registerSingleton<Config>(mockConfig);

      whenListen(
        mockScaffoldCubit,
        Stream<sc.ScaffoldState>.fromIterable([]),
        initialState: const sc.ScaffoldInitial(),
      );

      await tester
          .pumpApp(wrapWithDependencies(MainScaffold(child: Container())));

      await tester.tap(find.byIcon(Icons.menu));

      await tester.pump();

      await expectLater(find.byType(ClubDrawer), findsOneWidget);
    });

    testWidgets('should add widgets in scaffoldState', (tester) async {
      const Key appbarKey = Key('appbar');
      const IconData actionButtonIcon = Icons.ac_unit;
      final MockCaller mockCaller = MockCaller();

      final scaffoldCubitController = stubCubitStream(mockScaffoldCubit,
          initialState: const sc.ScaffoldInitial());

      await tester
          .pumpApp(wrapWithDependencies(MainScaffold(child: Container())));

      await expectLater(find.byKey(appbarKey), findsNothing);

      scaffoldCubitController.add(sc.ScaffoldUpdate(MainScaffoldParts(
          actionButtons: [
            ActionButton(icon: actionButtonIcon, onClick: mockCaller.call)
          ],
          titleBarWidget: Container(key: appbarKey))));

      await tester.pump();

      await expectLater(find.byKey(appbarKey), findsOneWidget);
      await expectLater(find.byIcon(actionButtonIcon), findsOneWidget);

      verifyNever(() => mockCaller.call());

      await tester.tap(find.byIcon(actionButtonIcon));

      verify(() => mockCaller.call()).called(1);
    });
  });
}
