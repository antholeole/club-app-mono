part of 'main_cubit.dart';

class MainState extends Union5Impl<MainLoading, MainLoadFailure, MainGroupless,
    MainWithGroup, MainLogOut> {
  static const unions = Quintet<MainLoading, MainLoadFailure, MainGroupless,
      MainWithGroup, MainLogOut>();

  MainState._(
      Union5<MainLoading, MainLoadFailure, MainGroupless, MainWithGroup,
              MainLogOut>
          union)
      : super(union);

  factory MainState.loading() => MainState._(unions.first(const MainLoading()));

  factory MainState.loadFailure(Failure f) =>
      MainState._(unions.second(MainLoadFailure(failure: f)));

  factory MainState.groupless() =>
      MainState._(unions.third(const MainGroupless()));

  factory MainState.withGroup(Group group) =>
      MainState._(unions.fourth(MainWithGroup(group: group)));

  factory MainState.logOut(String? withError) =>
      MainState._(unions.fifth(MainLogOut(withError: withError)));

  Group? get group {
    return join((_) => null, (_) => null, (_) => null, (mpwgs) => mpwgs.group,
        (_) => null);
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
  List<Object?> get props => [];
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
