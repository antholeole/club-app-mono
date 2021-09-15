part of 'main_cubit.dart';

class MainState extends Union6Impl<MainLoading, MainLoadFailure, MainGroupless,
    MainWithGroup, MainLogOut, MainDm> {
  @override
  String toString() =>
      join((a) => a, (b) => b, (c) => c, (d) => d, (e) => e, (f) => f)
          .toString();

  static const unions = Sextet<MainLoading, MainLoadFailure, MainGroupless,
      MainWithGroup, MainLogOut, MainDm>();

  MainState._(
      Union6<MainLoading, MainLoadFailure, MainGroupless, MainWithGroup,
              MainLogOut, MainDm>
          union)
      : super(union);

  factory MainState.loading() => MainState._(unions.first(const MainLoading()));

  factory MainState.loadFailure(Failure f) =>
      MainState._(unions.second(MainLoadFailure(failure: f)));

  factory MainState.groupless() =>
      MainState._(unions.third(const MainGroupless()));

  factory MainState.withGroup(Group group) =>
      MainState._(unions.fourth(MainWithGroup(group: group)));

  factory MainState.logOut({String? withError}) =>
      MainState._(unions.fifth(MainLogOut(withError: withError)));

  factory MainState.dm({required User withUser}) =>
      MainState._(unions.sixth(MainDm(withUser: withUser)));

  Group? get group {
    return join((_) => null, (_) => null, (_) => null, (mpwg) => mpwg.group,
        (_) => null, (_) => null);
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

class MainDm extends Equatable {
  final User withUser;

  const MainDm({required this.withUser});

  @override
  List<Object?> get props => [withUser];
}

class MainGroupless extends Equatable {
  const MainGroupless();

  @override
  List<Object?> get props => [];
}

class MainWithGroup extends Equatable {
  final Group group;

  const MainWithGroup({required this.group});

  @override
  List<Object?> get props => [group];
}

class MainLogOut extends Equatable {
  final String? withError;

  const MainLogOut({this.withError});

  @override
  List<Object?> get props => [withError];
}
