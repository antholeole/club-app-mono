import 'package:bloc_test/bloc_test.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/services/toaster/toast_display.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../test_helpers/mocks.dart';
import '../../test_helpers/pump_app.dart';
import '../../test_helpers/reset_mock_bloc.dart';

void main() {
  final mockToasterCubit = MockToasterCubit.getMock();

  Widget wrapWithDependencies(Widget child) {
    return BlocProvider<ToasterCubit>(
      create: (context) => mockToasterCubit,
      child: child,
    );
  }

  setUp(() {
    resetMockBloc(mockToasterCubit);
  });

  ToastType.values.forEach((toastType) {
    testWidgets('should render $toastType with proper render options',
        (tester) async {
      await tester.pumpApp(ToastDisplay(
          toast: Toast(
              message: 'hi',
              type: toastType,
              action: ToastAction(action: () {}, actionText: 'hi'))));

      final icon = tester.firstWidget<Icon>(find.byType(Icon));
      expect(icon, equals(toastType.icon));
    });
  });

  group('action', () {
    const text = 'skmzkxmckzmxck';

    testWidgets('should be rendered if action exists', (tester) async {
      await tester.pumpApp(wrapWithDependencies(
        ToastDisplay(
            toast: Toast(
                message: 'hi',
                type: ToastType.Error,
                action: ToastAction(action: () {}, actionText: text))),
      ));

      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should not be rendered if action does not exist',
        (tester) async {
      await tester.pumpApp(wrapWithDependencies(
        ToastDisplay(
            toast: Toast(
          message: 'hi',
          type: ToastType.Error,
        )),
      ));

      expect(find.text(text), findsNothing);
    });

    testWidgets('should call and dismiss on click', (tester) async {
      final caller = MockCaller();
      final toastId = UuidType.generate();

      whenListen(mockToasterCubit, const Stream<ToasterState>.empty());

      await tester.pumpApp(wrapWithDependencies(
        ToastDisplay(
            toast: Toast(
                message: 'hi',
                type: ToastType.Error,
                id: toastId,
                action: ToastAction(action: caller.call, actionText: text))),
      ));

      await tester.tap(find.text(text));

      verify(() => caller.call()).called(1);
      verify(() => mockToasterCubit.remove(toastId));
    });
  });
}
