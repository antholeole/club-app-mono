part of '../update_groups_cubit.dart';

class GroupsPageGroup extends Equatable {
  final Group group;

  final JoinTokenState joinTokenState;
  final LeavingState leaveState;

  const GroupsPageGroup(
      {required this.group,
      required this.joinTokenState,
      required this.leaveState});

  @override
  List<Object?> get props => [group, joinTokenState, leaveState];
}

class LeavingState extends Union4Impl<NotLeavingState, CurrentlyLeavingState,
    PromptLeavingState, FailureLeavingState> {
  @override
  String toString() => join((a) => a.toString(), (a) => a.toString(),
      (a) => a.toString(), (a) => a.toString());

  static const unions = Quartet<NotLeavingState, CurrentlyLeavingState,
      PromptLeavingState, FailureLeavingState>();

  LeavingState._(
      Union4<NotLeavingState, CurrentlyLeavingState, PromptLeavingState,
              FailureLeavingState>
          union)
      : super(union);

  factory LeavingState.notLeaving() =>
      LeavingState._(unions.first(const NotLeavingState()));

  factory LeavingState.leaving() =>
      LeavingState._(unions.second(const CurrentlyLeavingState()));

  factory LeavingState.prompting(
          {required Future<void> Function() accepted,
          required VoidCallback rejected}) =>
      LeavingState._(unions
          .third(PromptLeavingState(accepted: accepted, rejected: rejected)));

  factory LeavingState.failure(Failure f) =>
      LeavingState._(unions.fourth(FailureLeavingState(failure: f)));
}

class FailureLeavingState extends Equatable {
  final Failure failure;

  const FailureLeavingState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class NotLeavingState extends Equatable {
  const NotLeavingState();

  @override
  List<Object?> get props => [];
}

class CurrentlyLeavingState extends Equatable {
  const CurrentlyLeavingState();

  @override
  List<Object?> get props => [];
}

class PromptLeavingState extends Equatable {
  final Future<void> Function() accepted;
  final VoidCallback rejected;

  const PromptLeavingState({required this.rejected, required this.accepted});

  @override
  List<Object?> get props => [];
}

class JoinTokenState
    extends Union3Impl<NotAdmin, AdminLoading, AdminWithToken> {
  @override
  String toString() =>
      join((a) => a.toString(), (a) => a.toString(), (a) => a.toString());

  static const unions = Triplet<NotAdmin, AdminLoading, AdminWithToken>();

  JoinTokenState._(Union3<NotAdmin, AdminLoading, AdminWithToken> union)
      : super(union);

  factory JoinTokenState.notAdmin() =>
      JoinTokenState._(unions.first(const NotAdmin()));

  factory JoinTokenState.adminLoading() =>
      JoinTokenState._(unions.second(const AdminLoading()));

  factory JoinTokenState.adminWithToken(String? token) =>
      JoinTokenState._(unions.third(AdminWithToken(token: token)));
}

class NotAdmin extends Equatable {
  const NotAdmin();

  @override
  List<Object?> get props => [];
}

class AdminLoading extends Equatable {
  const AdminLoading();

  @override
  List<Object?> get props => [];
}

class AdminWithToken extends Equatable {
  final String? token;

  const AdminWithToken({required this.token});

  @override
  List<Object?> get props => [token];
}
