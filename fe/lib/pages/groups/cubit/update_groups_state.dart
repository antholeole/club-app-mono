part of 'update_groups_cubit.dart';

class UpdateGroupsState extends Union4Impl<FetchGroupsState, UpdateGroupsInital,
    FetchedGroupsState, FetchGroupsFailureState> {
  @override
  String toString() => join((a) => a.toString(), (a) => a.toString(),
      (a) => a.toString(), (a) => a.toString());

  static const unions = Quartet<FetchGroupsState, UpdateGroupsInital,
      FetchedGroupsState, FetchGroupsFailureState>();

  UpdateGroupsState._(
      Union4<FetchGroupsState, UpdateGroupsInital, FetchedGroupsState,
              FetchGroupsFailureState>
          union)
      : super(union);

  factory UpdateGroupsState.fetchGroups() =>
      UpdateGroupsState._(unions.first(const FetchGroupsState()));

  factory UpdateGroupsState.inital() =>
      UpdateGroupsState._(unions.second(const UpdateGroupsInital()));

  factory UpdateGroupsState.fetched(Map<UuidType, GroupsPageGroup> groups) =>
      UpdateGroupsState._(unions.third(FetchedGroupsState(groups: groups)));

  factory UpdateGroupsState.failure(Failure f) =>
      UpdateGroupsState._(unions.fourth(FetchGroupsFailureState(failure: f)));

  Map<UuidType, GroupsPageGroup>? get groups {
    return join((_) => null, (_) => null, (fgs) => fgs.groups, (_) => null);
  }
}

class UpdateGroupsInital extends Equatable {
  const UpdateGroupsInital();

  @override
  List<Object?> get props => [];
}

class FetchGroupsState extends Equatable {
  const FetchGroupsState();

  @override
  List<Object?> get props => [];
}

class FetchedGroupsState extends Equatable {
  final Map<UuidType, GroupsPageGroup> groups;

  const FetchedGroupsState({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class FetchGroupsFailureState extends Equatable {
  final Failure failure;

  const FetchGroupsFailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
