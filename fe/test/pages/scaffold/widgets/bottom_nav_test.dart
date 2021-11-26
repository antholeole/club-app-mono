import 'package:bloc_test/bloc_test.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/bottom_nav.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/reset_mock_bloc.dart';

void main() {
  final mockPageCubit = MockPageCubit.getMock();

  Widget wrapWithDependencies(Widget child) {
    return BlocProvider<PageCubit>(
      create: (_) => mockPageCubit,
      child: child,
    );
  }

  setUp(() async {
    resetMockBloc(mockPageCubit);
    await registerAllMockServices();
  });

  group('chat tab', () {
    testWidgets('should switch to chat on single click', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());

      when(() => mockPageCubit.bottomSheet(any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const BottomNav()));

      await tester.tap(find.byIcon(BottomNav.CHAT_TAB_ICON));
      await tester.pump();

      verify(() => mockPageCubit.switchTo(AppPage.Chat)).called(1);
    });

    testWidgets('should open bottom sheet on held', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());

      when(() => mockPageCubit.bottomSheet(any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const BottomNav()));

      await tester.longPress(find.byIcon(BottomNav.CHAT_TAB_ICON));
      await tester.pump();

      verify(() => mockPageCubit.bottomSheet(any())).called(1);
    });
    testWidgets('should open bottom sheet on double click', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.chatPage());

      when(() => mockPageCubit.bottomSheet(any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const BottomNav()));

      await tester.tap(find.byIcon(BottomNav.CHAT_TAB_ICON));
      await tester.pump();

      verify(() => mockPageCubit.bottomSheet(any())).called(1);
    });
  });

  group('events tab', () {
    testWidgets('should switch to event on single click', (tester) async {
      whenListen(mockPageCubit, Stream<PageState>.fromIterable([]),
          initialState: PageState.eventPage());

      when(() => mockPageCubit.bottomSheet(any()))
          .thenAnswer((_) async => null);

      await tester.pumpApp(wrapWithDependencies(const BottomNav()));

      await tester.tap(find.byIcon(BottomNav.EVENT_TAB_ICON));
      await tester.pump();

      verify(() => mockPageCubit.switchTo(AppPage.Events)).called(1);
    });
  });
}
