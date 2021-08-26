import 'package:bloc_test/bloc_test.dart';
import 'package:fe/data/json/backend_access_tokens.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/login/cubit/login_cubit.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/profile/cubit/name_change_cubit.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/pages/splash/cubit/splash_cubit.dart';
import 'package:fe/services/clients/http_client/unauth_http_client.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/local_data/image_handler.dart';
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

import '../reset_mock_bloc.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockUpdateGroupsCubit extends MockCubit<UpdateGroupsState>
    implements UpdateGroupsCubit {
  MockUpdateGroupsCubit._();

  factory MockUpdateGroupsCubit.getMock() {
    registerFallbackValue(UpdateGroupsState.fetchingGroups());
    final cubit = MockUpdateGroupsCubit._();
    resetMockCubit(cubit);
    return cubit;
  }
}

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

class MockScaffoldCubit extends MockCubit<ScaffoldState>
    implements ScaffoldCubit {
  MockScaffoldCubit._();

  factory MockScaffoldCubit.getMock() {
    registerFallbackValue(MockScaffoldState());
    final mockScaffoldCubit = MockScaffoldCubit._();
    when(() => mockScaffoldCubit.close())
        .thenAnswer((invocation) async => null);
    return mockScaffoldCubit;
  }
}

class MockScaffoldState extends Fake implements ScaffoldState {}

class MockToasterCubit extends MockCubit<ToasterState> implements ToasterCubit {
  MockToasterCubit._();

  factory MockToasterCubit.getMock() {
    registerFallbackValue(ToasterState());
    registerFallbackValue(Toast(message: 'h', type: ToastType.Error));

    final cubit = MockToasterCubit._();
    return cubit;
  }
}

class MockThreadCubit extends MockCubit<ThreadState> implements ThreadCubit {
  MockThreadCubit._();

  factory MockThreadCubit.getMock() {
    registerFallbackValue(ThreadState.noThread());
    final cubit = MockThreadCubit._();
    when(() => cubit.close()).thenAnswer((invocation) async => null);
    return cubit;
  }
}

class MockChatCubit extends MockCubit<ChatState> implements ChatCubit {
  MockChatCubit._();

  factory MockChatCubit.getMock() {
    registerFallbackValue(ChatState.inital());
    final cubit = MockChatCubit._();
    when(() => cubit.close()).thenAnswer((invocation) async => null);
    return cubit;
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

class MockMainCubit extends MockCubit<MainState> implements MainCubit {
  MockMainCubit._();

  factory MockMainCubit.getMock() {
    registerFallbackValue(MockMainState());
    final cubit = MockMainCubit._();
    return cubit;
  }
}

class MockMainState extends Fake implements MainState {}

class MockChatBottomSheetCubit extends MockCubit<bool>
    implements ChatBottomSheetCubit {
  MockChatBottomSheetCubit._();

  factory MockChatBottomSheetCubit.getMock() {
    final cubit = MockChatBottomSheetCubit._();

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

class MockPageCubit extends MockCubit<PageState> implements PageCubit {
  MockPageCubit._();

  factory MockPageCubit.getMock() {
    registerFallbackValue(MockPageState());
    final cubit = MockPageCubit._();
    return cubit;
  }
}

class MockPageState extends Fake implements PageState {}

class MockImageHandler extends Mock implements ImageHandler {
  MockImageHandler._();

  static MockImageHandler getMock() {
    registerFallbackValue(ImageProviderFake());
    return MockImageHandler._();
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

class MockGqlClient extends Mock implements Client {
  MockGqlClient._();

  factory MockGqlClient.getMock() {
    registerFallbackValue(FakeRequest());
    registerFallbackValue(FakeResponse());
    return MockGqlClient._();
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
}

class FakeGoogleSignInAuthentication implements GoogleSignInAuthentication {
  @override
  String? get accessToken => 'accesstoken';

  @override
  String? get idToken => 'idtoken';

  @override
  String? get serverAuthCode => 'ad123123';
}

class MockUnauthHttpClient extends Mock implements UnauthHttpClient {}

class MockHttpClient extends Mock implements http.Client {
  MockHttpClient._();

  factory MockHttpClient.getMock() {
    final client = MockHttpClient._();

    registerFallbackValue(MockBaseRequest());

    return client;
  }
}

class MockBaseRequest extends Fake implements http.BaseRequest {}

class MockWsClient extends Mock implements WsClient {
  MockWsClient._();

  factory MockWsClient.getMock() {
    final client = MockWsClient._();
    when(() => client.initalize()).thenAnswer((invocation) async => null);
    return client;
  }

  void emptyStub() {
    when(() => connectionState).thenAnswer((_) => const Stream.empty());
    when(() => failureStream).thenAnswer((_) => const Stream.empty());
    when(() => messageStream).thenAnswer((_) => const Stream.empty());
    when(() => close()).thenAnswer((_) async => null);
  }
}

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
