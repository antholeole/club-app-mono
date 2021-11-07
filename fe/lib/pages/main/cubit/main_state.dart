part of 'main_cubit.dart';

class MainState extends Union6Impl<MainLoading, MainLoadFailure, MainGroupless,
    MainWithClub, MainLogOut, MainWithDm> {
  @override
  String toString() =>
      join((a) => a, (b) => b, (c) => c, (d) => d, (e) => e, (f) => f)
          .toString();

  static const unions = Sextet<MainLoading, MainLoadFailure, MainGroupless,
      MainWithClub, MainLogOut, MainWithDm>();

  MainState._(
      Union6<MainLoading, MainLoadFailure, MainGroupless, MainWithClub,
              MainLogOut, MainWithDm>
          union)
      : super(union);

  factory MainState.loading() => MainState._(unions.first(const MainLoading()));

  factory MainState.loadFailure(Failure f) =>
      MainState._(unions.second(MainLoadFailure(failure: f)));

  factory MainState.groupless() =>
      MainState._(unions.third(const MainGroupless()));

  factory MainState.withClub(Club group) =>
      MainState._(unions.fourth(MainWithClub(club: group)));

  factory MainState.logOut({String? withError}) =>
      MainState._(unions.fifth(MainLogOut(withError: withError)));

  factory MainState.withDm({required Dm dm}) =>
      MainState._(unions.sixth(MainWithDm(dm)));

  UuidType? get groupId {
    return join((_) => null, (_) => null, (_) => null, (mpwg) => mpwg.club.id,
        (_) => null, (dm) => dm.dm.id);
  }
}

class MainLoading extends Equatable {
  const MainLoading();

  @override
  List<Object?> get props => [];
}

class MainLoadFailure extends Equatable {
  final Failure failure;

  const MainLoadFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class MainWithDm extends Equatable {
  final Dm dm;

  const MainWithDm(this.dm);

  @override
  List<Object?> get props => [dm];
}

class MainGroupless extends Equatable {
  const MainGroupless();

  @override
  List<Object?> get props => [];
}

class MainWithClub extends Equatable {
  final Club club;

  const MainWithClub({required this.club});

  @override
  List<Object?> get props => [club];
}

class MainLogOut extends Equatable {
  final String? withError;

  const MainLogOut({this.withError});

  @override
  List<Object?> get props => [withError];
}
