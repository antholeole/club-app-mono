part of 'name_change_cubit.dart';

@immutable
class NameChangeState
    extends Union3Impl<NotChangingName, NameChangeChanging, NameChangeFailure> {
  @override
  String toString() =>
      join((a) => a.toString(), (a) => a.toString(), (a) => a.toString());

  static const unions =
      Triplet<NotChangingName, NameChangeChanging, NameChangeFailure>();

  NameChangeState._(
      Union3<NotChangingName, NameChangeChanging, NameChangeFailure> union)
      : super(union);

  factory NameChangeState.notChanging() =>
      NameChangeState._(unions.first(NotChangingName()));

  factory NameChangeState.changing() =>
      NameChangeState._(unions.second(NameChangeChanging()));

  factory NameChangeState.failure(Failure failure) =>
      NameChangeState._(unions.third(NameChangeFailure(failure: failure)));
}

class NotChangingName extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChangeChanging extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChangeFailure extends Equatable {
  final Failure failure;

  const NameChangeFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
