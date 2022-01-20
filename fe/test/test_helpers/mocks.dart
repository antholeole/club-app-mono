import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/gql/fake/fake.req.gql.dart';
import 'package:fe/pages/chat/features/chat_display/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/features/chat_display/cubit/chat_state.dart';
import 'package:fe/pages/chat/features/message_overlay/cubit/message_overlay_cubit.dart';
import 'package:fe/pages/chat/features/message_overlay/cubit/message_overlay_state.dart';
import 'package:fe/pages/chat/features/send/cubit/send_cubit.dart';
import 'package:fe/pages/chat/features/send/cubit/send_state.dart';
import 'package:fe/pages/login/view/features/login/cubit/login_cubit.dart';
import 'package:fe/pages/login/view/features/login/cubit/login_state.dart';
import 'package:fe/pages/profile/features/name_change/cubit/name_change_cubit.dart';
import 'package:fe/pages/profile/features/name_change/cubit/name_change_state.dart';
import 'package:fe/pages/splash/features/app_boot/cubit/splash_cubit.dart';
import 'package:fe/pages/splash/features/app_boot/cubit/splash_state.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/clients/gql_client/unauth_gql_client.dart';
import 'package:fe/services/local_data/image_cache_handler.dart';
import 'package:fe/services/local_data/local_file_store.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FakeBuildContext extends Fake implements BuildContext {}

class MockNameChangeCubit extends MockCubit<NameChangeState>
    implements NameChangeCubit {
  MockNameChangeCubit._();

  factory MockNameChangeCubit.getMock() {
    registerFallbackValue(NameChangeState.changing());
    final mockNameChangeCubit = MockNameChangeCubit._();
    when(() => mockNameChangeCubit.close())
        .thenAnswer((invocation) async => null);
    return mockNameChangeCubit;
  }
}

class MockSplashCubit extends MockCubit<SplashState> implements SplashCubit {
  MockSplashCubit._();

  factory MockSplashCubit.getMock() {
    registerFallbackValue(MockSplashState());
    final mockSplashCubit = MockSplashCubit._();
    when(() => mockSplashCubit.close()).thenAnswer((invocation) async => null);
    return mockSplashCubit;
  }
}

class MockSplashState extends Fake implements SplashState {}

class MockToasterCubit extends MockCubit<ToasterState> implements ToasterCubit {
  MockToasterCubit._();

  factory MockToasterCubit.getMock() {
    registerFallbackValue(ToasterState());
    registerFallbackValue(Toast(message: 'h', type: ToastType.Error));

    final cubit = MockToasterCubit._();
    return cubit;
  }
}

class MockSendCubit extends MockCubit<List<SendState>> implements SendCubit {
  MockSendCubit._();

  factory MockSendCubit.getMock() {
    registerFallbackValue([
      SendState.sending(Message.text(
          createdAt: clock.now(),
          id: UuidType.generate(),
          text: 'asdas',
          updatedAt: clock.now(),
          user: User(name: 'asdasd', id: UuidType.generate())))
    ]);
    final cubit = MockSendCubit._();
    when(() => cubit.close()).thenAnswer((invocation) async => null);
    return cubit;
  }
}

class MockChatBloc extends MockCubit<ChatState> implements ChatCubit {
  MockChatBloc._();

  factory MockChatBloc.getMock() {
    registerFallbackValue(const ChatState.loading());
    final bloc = MockChatBloc._();
    when(() => bloc.close()).thenAnswer((invocation) async => null);
    return bloc;
  }
}

class MockLocalFileStore extends Mock implements LocalFileStore {
  MockLocalFileStore._();

  static MockLocalFileStore getMock() {
    registerFallbackValue(LocalStorageType.AccessTokens);
    registerFallbackValue(User(name: 'asdas', id: UuidType.generate()));
    return MockLocalFileStore._();
  }
}

class MockMessageOverlayCubit extends MockCubit<MessageOverlayState>
    implements MessageOverlayCubit {
  MockMessageOverlayCubit._();

  factory MockMessageOverlayCubit.getMock() {
    registerFallbackValue(MessageOverlayState.none());

    final cubit = MockMessageOverlayCubit._();

    return cubit;
  }
}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  MockLoginCubit._();

  factory MockLoginCubit.getMock() {
    registerFallbackValue(LoginState.initial());
    final cubit = MockLoginCubit._();
    return cubit;
  }
}

class MockImageCacheHandler extends Mock implements ImageCacheHandler {
  MockImageCacheHandler._();

  static MockImageCacheHandler getMock() {
    registerFallbackValue(ImageProviderFake());
    return MockImageCacheHandler._();
  }
}

class ImageProviderFake extends Fake implements ImageProvider {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockTokenManager extends Mock implements TokenManager {
  MockTokenManager._();

  factory MockTokenManager.getMock() {
    registerFallbackValue(BackendAccessTokens(
        accessToken: 'a',
        refreshToken: 'a',
        name: 'a',
        id: UuidType.generate()));
    registerFallbackValue(FakeResponse());
    return MockTokenManager._();
  }
}

class MockLocalUserService extends Mock implements LocalUserService {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockClient extends Mock implements Client {
  MockClient._();

  factory MockClient.getMock() {
    registerFallbackValue(FakeRequest());
    registerFallbackValue(FakeResponse());
    return MockClient._();
  }
}

class FakeRequest<TData, TVars> extends Fake
    implements OperationRequest<TData, TVars> {
  static void registerOfType<TData, TVars>() {
    registerFallbackValue(FakeRequest<TData, TVars>());
  }
}

class FakeResponse extends Fake implements OperationResponse {}

class MockCache extends Mock implements Cache {}

class FakeUuidType extends Fake implements UuidType {}

class FakeLinkException extends LinkException {
  const FakeLinkException(Object originalException) : super(originalException);
}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class FakeGoogleSignIn implements GoogleSignInAccount {
  @override
  bool operator ==(dynamic obj) {
    return obj == obj;
  }

  String? get idToken => 'id token';

  /// The OAuth2 access token to access Google services.
  String? get accessToken => 'accestoken';

  @override
  Future<Map<String, String>> get authHeaders async => {};

  @override
  Future<GoogleSignInAuthentication> get authentication =>
      Future.value(FakeGoogleSignInAuthentication());

  @override
  Future<void> clearAuthCache() async {}

  @override
  String? get displayName => 'fake display';

  @override
  String get email => 'email';

  @override
  String get id => 'asdas';

  @override
  String? get photoUrl => 'asdasds';

  @override
  String? get serverAuthCode => throw UnimplementedError();
}

class FakeGoogleSignInAuthentication implements GoogleSignInAuthentication {
  @override
  String? get accessToken => 'accesstoken';

  @override
  String? get idToken => 'idtoken';

  @override
  String? get serverAuthCode => 'ad123123';
}

class MockGqlClient extends Mock implements AuthGqlClient {
  MockGqlClient._();

  factory MockGqlClient.getMock() {
    final MockGqlClient mockGqlClient = MockGqlClient._();

    registerFallbackValue(GFakeGqlReq());

    return mockGqlClient;
  }
}

class MockUnauthGqlClient extends Mock implements UnauthGqlClient {}

class MockConnectivity extends Mock implements Connectivity {}

class MockHttpClient extends Mock implements http.Client {
  MockHttpClient._();

  factory MockHttpClient.getMock() {
    final client = MockHttpClient._();

    registerFallbackValue(MockBaseRequest());

    return client;
  }
}

class MockBaseRequest extends Fake implements http.BaseRequest {}

class FakeImageProvider extends Mock implements ImageProvider {}

class FakeImageInfo extends Mock implements ImageInfo {}

class FakeImageStream extends Mock implements ImageStream {
  @override
  String toString({DiagnosticLevel? minLevel}) {
    return '';
  }
}

class MockHandler extends Mock implements Handler {
  MockHandler._();

  factory MockHandler.getMock() {
    final handler = MockHandler._();
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(const Failure(status: FailureStatus.GQLMisc));
    return handler;
  }
}

class _Caller {
  const _Caller();
  void call() {}
}

//allows us to pass in arbitrary methods, verifying that this was called
class MockCaller extends Mock implements _Caller {}

class MockScrollController extends Mock implements ScrollController {}
