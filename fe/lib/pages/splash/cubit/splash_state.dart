part of 'splash_cubit.dart';

class SplashState
    extends Union3Impl<SplashInitial, SplashNotLoggedIn, SplashLoggedIn> {
  static const unions =
      Triplet<SplashInitial, SplashNotLoggedIn, SplashLoggedIn>();

  SplashState._(Union3<SplashInitial, SplashNotLoggedIn, SplashLoggedIn> union)
      : super(union);

  factory SplashState.initial() =>
      SplashState._(unions.first(const SplashInitial()));

  factory SplashState.notLoggedIn() =>
      SplashState._(unions.second(const SplashNotLoggedIn()));

  factory SplashState.loggedIn(User user) =>
      SplashState._(unions.third(SplashLoggedIn(user: user)));
}

class SplashInitial extends Equatable {
  const SplashInitial();

  @override
  List<Object?> get props => [];
}

class SplashNotLoggedIn extends Equatable {
  const SplashNotLoggedIn();

  @override
  List<Object?> get props => [];
}

class SplashLoggedIn extends Equatable {
  final User user;

  const SplashLoggedIn({required this.user});

  @override
  List<Object?> get props => [user];
}
