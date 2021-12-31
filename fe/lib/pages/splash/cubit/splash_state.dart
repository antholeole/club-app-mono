import 'package:fe/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  factory SplashState.initial() = _Inital;
  factory SplashState.notLoggedIn() = _NotLoggedIn;
  factory SplashState.loggedIn(User user) = _LoggedIn;
}
