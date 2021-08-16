part of 'update_groups_cubit.dart';

class UpdateGroupsState extends Union3Impl<FetchGroupsState, FetchedGroupsState,
    FetchGroupsFailureState> {
  @override
  String toString() =>
      join((a) => a.toString(), (a) => a.toString(), (a) => a.toString());

  static const unions =
      Triplet<FetchGroupsState, FetchedGroupsState, FetchGroupsFailureState>();

  UpdateGroupsState._(
      Union3<FetchGroupsState, FetchedGroupsState, FetchGroupsFailureState>
          union)
      : super(union);

  factory UpdateGroupsState.fetchingGroups() =>
      UpdateGroupsState._(unions.first(const FetchGroupsState()));

  factory UpdateGroupsState.fetched(Map<UuidType, GroupsPageGroup> groups) =>
      UpdateGroupsState._(unions.second(FetchedGroupsState(groups: groups)));

  factory UpdateGroupsState.failure(Failure f) =>
      UpdateGroupsState._(unions.third(FetchGroupsFailureState(failure: f)));

  Map<UuidType, GroupsPageGroup>? get groups {
    return join((_) => null, (fgs) => fgs.groups, (_) => null);
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
