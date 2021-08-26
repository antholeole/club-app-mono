import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/json/provider_access_token.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';

void main() {
  group('login cubit', () {
    final userId = UuidType.generate();

    setUpAll(() {
      registerFallbackValue(User(name: 'a', id: UuidType.generate()));
    });

    setUp(() {
      registerAllMockServices();
    });

    group('google auth', () {
      blocTest<LoginCubit, LoginState>(
          'should emit inital if google auth returns null',
          setUp: () => when(() => getIt<GoogleSignIn>().signIn())
              .thenAnswer((_) async => null),
          build: () => LoginCubit(),
          act: (cubit) => cubit.login(LoginType.Google),
          expect: () => [LoginState.loading(), LoginState.initial()]);

      blocTest<LoginCubit, LoginState>('should emit exception on exception',
          setUp: () =>
              when(() => getIt<GoogleSignIn>().signIn()).thenThrow(Exception()),
          build: () => LoginCubit(),
          act: (cubit) => cubit.login(LoginType.Google),
          expect: () => [
                LoginState.loading(),
                LoginState.failure(Failure(
                    status: FailureStatus.Unknown,
                    message: Exception().toString()))
              ]);
    });

    blocTest<LoginCubit, LoginState>(
        'should emit success and write tokens to storage on successful login',
        setUp: () {
          when(() => getIt<GoogleSignIn>().signIn())
              .thenAnswer((_) async => FakeGoogleSignIn());

          when(() => getIt<UnauthHttpClient>().postReq(any(), any()))
              .thenAnswer((_) async => Response(
                  json.encode(BackendAccessTokens(
                          accessToken: 'accessToken',
                          id: userId,
                          name: 'asdasd',
                          refreshToken: 'refreshmeplz')
                      .toJson()),
                  200));

          when(() => getIt<TokenManager>().initalizeTokens(any()))
              .thenAnswer((_) async => null);

          when(() => getIt<LocalUserService>().saveChanges(any()))
              .thenAnswer((_) async => null);
        },
        build: () => LoginCubit(),
        act: (cubit) => cubit.login(LoginType.Google),
        expect: () => [
              LoginState.loading(),
              LoginState.success(
                  User(id: userId, name: 'as', profilePictureUrl: 'a'))
            ],
        verify: (_) {
          when(() => getIt<TokenManager>().initalizeTokens(any()))
              .thenAnswer((_) async => null);
          verify(() => getIt<LocalUserService>().saveChanges(any())).called(1);
        });
  });
}
