import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/widgets/sign_in_with_provider_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/fixtures/mocks.dart';
import '../../../../test_helpers/pump_app.dart';
import '../../../../test_helpers/reset_mock_bloc.dart';

void main() {
  final mockLoginCubit = MockLoginCubit.getMock();

  setUp(() {
    resetMockCubit(mockLoginCubit);
    registerFallbackValue(LoginType.Google);
  });

  group('sign in with provider button', () {
    LoginType.values.forEach((loginType) async {
      testWidgets(
          'should call loginCubit.login(${loginType.toString()})  '
          'when login with ${loginType.toString()} button clicked',
          (tester) async {
        whenListen(mockLoginCubit, Stream<LoginState>.fromIterable([]));

        when(() => mockLoginCubit.login(any())).thenAnswer((_) async => null);

        await tester.pumpApp(BlocProvider<LoginCubit>(
          create: (_) => mockLoginCubit,
          child: SignInWithProviderButton(
            loginType: loginType,
          ),
        ));

        await tester.tap(find.byType(SignInWithProviderButton));
        await tester.pump();

        verify(() => mockLoginCubit.login(loginType)).called(1);
      });
    });
  });
}
