import 'package:bloc_test/bloc_test.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/services/toaster/toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/fixtures/mocks.dart';
import '../../test_helpers/pump_app.dart';
import '../../test_helpers/reset_mock_bloc.dart';
import '../../test_helpers/stub_cubit_stream.dart';

void main() {
  const testMsg = 'gasdjpoaisj349j';

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

  testWidgets('should display new toast on new toast', (tester) async {
    final stream = stubBlocStream<ToasterState>(mockToasterCubit,
        initialState: ToasterState());

    await tester
        .pumpApp(wrapWithDependencies(ToasterDisplay(child: Container())));
    expect(find.text(testMsg), findsNothing);
    stream.add(
        ToasterState()..add(Toast(message: testMsg, type: ToastType.Success)));
    await tester.pump(const Duration(milliseconds: 10));

    expect(find.text(testMsg), findsOneWidget);
  });

  testWidgets('should remove on remove toast', (tester) async {
    final stream = stubBlocStream<ToasterState>(mockToasterCubit,
        initialState: ToasterState()
          ..add(Toast(message: testMsg, type: ToastType.Success)));

    await tester
        .pumpApp(wrapWithDependencies(ToasterDisplay(child: Container())));
    expect(find.text(testMsg), findsOneWidget);
    stream.add(ToasterState());
    await tester.pump(const Duration(milliseconds: 10));

    expect(find.text(testMsg), findsNothing);
  });

  testWidgets('should be able to show multiple toasts', (tester) async {
    final messages = ['first,', 'asdasd', 'sadaio'];

    final state = ToasterState();

    messages.forEach((message) =>
        state.add(Toast(message: message, type: ToastType.Success)));

    whenListen(mockToasterCubit, const Stream<ToasterState>.empty(),
        initialState: state);

    await tester
        .pumpApp(wrapWithDependencies(ToasterDisplay(child: Container())));

    messages.forEach((message) => expect(find.text(message), findsOneWidget));
  });
}
