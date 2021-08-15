part of 'login_cubit.dart';

@immutable
class LoginState
    extends Union4Impl<LoginInitial, LoginLoading, LoginSuccess, LoginFailure> {
  static const unions =
      Quartet<LoginInitial, LoginLoading, LoginSuccess, LoginFailure>();

  LoginState._(
      Union4<LoginInitial, LoginLoading, LoginSuccess, LoginFailure> union)
      : super(union);

  factory LoginState.initial() => LoginState._(unions.first(LoginInitial()));

  factory LoginState.loading() => LoginState._(unions.second(LoginLoading()));

  factory LoginState.success(User user) =>
      LoginState._(unions.third(LoginSuccess(user: user)));

  factory LoginState.failure(Failure failure) =>
      LoginState._(unions.fourth(LoginFailure(failure: failure)));
}

class LoginInitial extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginLoading extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends Equatable {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends Equatable {
  final Failure? failure;

  const LoginFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
