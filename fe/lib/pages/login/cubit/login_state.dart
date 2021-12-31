import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState.initial() = _Inital;
  factory LoginState.loading() = _Loading;
  factory LoginState.success(User user) = _Success;
  factory LoginState.failure(Failure failure) = _Failure;
}
