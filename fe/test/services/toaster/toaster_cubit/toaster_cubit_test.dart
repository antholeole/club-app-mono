import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';

void main() {
  final caller = MockCaller();

  final fakeToast = Toast(
      message: 'hi',
      type: ToastType.Success,
      expire: false,
      id: UuidType.generate());

  final fakeToastExpires = Toast.customExpire(
      message: 'hi',
      type: ToastType.Success,
      expireAt: clock.now().add(const Duration(seconds: 3)),
      id: UuidType.generate());

  setUp(() {
    reset(caller);
  });

  group('add', () {
    blocTest<ToasterCubit, ToasterState>('should add toast',
        build: () => ToasterCubit(),
        act: (cubit) => cubit.add(fakeToast),
        expect: () => [ToasterState()..add(fakeToast)]);

    blocTest<ToasterCubit, ToasterState>('should expire toast',
        build: () => ToasterCubit(),
        act: (cubit) {
          fakeAsync((async) {
            cubit.add(fakeToastExpires);
            async.elapse(fakeToastExpires.expireAt!
                .add(const Duration(seconds: 2))
                .difference(clock.now()));
          });
        },
        expect: () => [ToasterState()..add(fakeToastExpires), ToasterState()]);
  });

  group('remove', () {
    final dissmissableToastId = UuidType.generate();

    blocTest<ToasterCubit, ToasterState>('should remove toast',
        build: () => ToasterCubit(),
        act: (cubit) {
          cubit.add(fakeToast);
          cubit.remove(fakeToast.id);
        },
        expect: () => [ToasterState()..add(fakeToast), ToasterState()]);

    blocTest<ToasterCubit, ToasterState>('should call onDismiss',
        build: () => ToasterCubit(),
        act: (cubit) {
          cubit.add(Toast(
              message: 'h',
              type: ToastType.Error,
              id: dissmissableToastId,
              onDismiss: caller.call));
          cubit.remove(dissmissableToastId);
        },
        verify: (_) => verify(() => caller.call()).called(1));
  });
}
